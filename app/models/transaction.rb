# frozen_string_literal: true

# This class represent each individual transaction that changes
# the total balance of a store.
class Transaction < ApplicationRecord
  belongs_to :store, counter_cache: true
  belongs_to :cnab, optional: true, counter_cache: true
  has_one :user, through: :cnab
  enum transaction_type: { debit: 1,
                           ticket: 2,
                           financing: 3,
                           credit: 4,
                           loan_receival: 5,
                           sales: 6,
                           ted_receival: 7,
                           doc_receival: 8,
                           rent: 9 }

  after_create :update_store_balance

  validate :double_charge

  # Returns a method to be used at the transaction on the store balance
  def signal
    sum? ? '+' : '-'
  end

  # Is this transaction a subtraction?
  def subtraction?
    %w[ticket financing rent].include? transaction_type
  end

  # Is this transaction a sum?
  def sum?
    !subtraction?
  end

  # Receives a line from a CNAB file and parses it into a Trasaction instance
  def self.create_from_cnab(line)
    raise Exception::ArgumentError("Invalid CNAB line for\n #{line}") unless line.size == 80
    create!(transaction_type: line[0].to_i,
            date: Date.parse(line[1..8]),
            value: line[9..18].to_f/100,
            cpf: line[19..29],
            card: line[30..41],
            time: line[42..47].gsub(/(\d{2})(?=\d)/, '\\1:'),
            store: Store.find_or_create_by(name: line[62..80], owner: line[48..61]))
  end

  private

  # Updates store balance based on value and transaction type
  def update_store_balance
    store.update(balance: store.balance.send("#{signal}", value))
  end

  # Validates value for double charging
  def double_charge
    errors.add(:value, "Double charging detected") if double_charge?
  end

  # Checks if transaction is a double charging by date, time, card and value
  def double_charge?
    Transaction.unscoped.where.not(id: id)
               .where(date: date,
                      time: time,
                      card: card,
                      value: value).exists?
  end
end
