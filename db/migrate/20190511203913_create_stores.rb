# frozen_string_literal: true

class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.float :balance, default: 0
      t.string :name
      t.string :owner
      t.integer :transactions_count, default: 0

      t.timestamps
    end
  end
end
