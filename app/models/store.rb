# This class represent a store, a model that executes
# transactions to gain or spend it's balance.
class Store < ApplicationRecord
  has_many :transactions
end
