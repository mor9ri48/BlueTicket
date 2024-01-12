class Booking < ApplicationRecord
  # customer(1)←→booking(多)の関連付け
  belongs_to :customer
  # flight(1)←→booking(多)の関連付け
  belongs_to :flight
  # seat(多)←→booking(多)の関連付け
  has_many :booking_seat_flights, dependent: :destroy
  has_many :seats, through: :booking_seat_flights
end
