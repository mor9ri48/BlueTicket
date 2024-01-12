class Seat < ApplicationRecord
  # airmodel(1)←→seat(多)の関連付け
  belongs_to :airmodel
  # seats(多)←→bookings(多)の関連付け
  has_many :booking_seat_flights
  has_many :bookings, through: :booking_seat_flights
end
