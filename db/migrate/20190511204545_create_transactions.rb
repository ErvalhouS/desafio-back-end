# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :transaction_type
      t.date :date
      t.float :value, default: 0
      t.integer :cpf
      t.string :card
      t.time :time
      t.references :store, foreign_key: true
      t.references :cnab, foreign_key: true

      t.timestamps
    end
  end
end
