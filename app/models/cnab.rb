# frozen_string_literal: true

# An uploaded report that contains information about
# transactions to be created.
class Cnab < ApplicationRecord
  belongs_to :user
  has_many :transactions
  has_many :stores, through: :transactions
  has_one_attached :report

  validates :report, presence: true

  after_create :proccess_transactions

  # Returns an array of lines from the report file
  def report_lines
    LineBreaker.parse(download_report)
  end

  private

  # Proccesses transactions asynchronously
  def proccess_transactions
    CnabJob.perform_later(id: id)
  end

  # Download content from report file
  def download_report
    @report ||= ActiveStorage::Current.set(host: ENV['ACTIVESTORAGE_HOST']) do
      Net::HTTP.get URI.parse(report.service_url)
    end
  end
end
