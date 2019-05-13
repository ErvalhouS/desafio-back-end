# frozen_string_literal: true

class CreateCnabs < ActiveRecord::Migration[5.2]
  def change
    create_table :cnabs do |t|
      t.references :user, foreign_key: true
      t.datetime :proccessed_at
      t.integer :transactions_count, default: 0
      t.boolean :failure
      t.text :failure_message

      t.timestamps
    end
  end
end
