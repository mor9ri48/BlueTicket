class Customer < ApplicationRecord
  # customer(1)←→booking(多)の関連付け
  has_many :bookings, dependent: :destroy
end
