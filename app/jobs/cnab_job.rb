# frozen_string_literal: true

require 'net/http'
# A job the heavy lifting of translating a CNAB file
# into Transaction objects
class CnabJob < ApplicationJob
  rescue_from(ActiveRecord::RecordNotFound) do
    retry_job wait: 10.seconds, queue: :default
  end

  queue_as :default

  def perform(args = {})
    @cnab = Cnab.find(args[:id])
    ActiveRecord::Base.transaction do
      @cnab.report_lines.each do |line|
        @cnab.transactions.create_from_cnab(line)
      end
      @cnab.proccessed_at = Time.now
      @cnab.save!
    end
  rescue StandardError => error
    @cnab.update(failure: true, failure_message: error.message)
    raise error if error.is_a? ActiveRecord::RecordNotFound
  end
end
