# frozen_string_literal: true

# A user of the system, someone that can upload CNAB
# reports.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i[facebook]
  has_many :cnabs
  has_many :transactions, through: :cnabs
  has_many :stores, through: :cnabs
end
