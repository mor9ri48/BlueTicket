class Flight < ApplicationRecord
  # airline(1)←→flight(多)の関連付け
  belongs_to :airline
  # airport(1)←→flight(多)の関連付け
  belongs_to :origin, class_name: "Airport"
  belongs_to :destination, class_name: "Airport"
  # airmodel(1)←→flight(多)の関連付け
  belongs_to :airmodel

  # flight(1)←→booking(多)の関連付け
  has_many :bookings

  # flight(多)←→seats(多)の関連付け
  has_many :booking_seat_flights
  has_many :seats, through: :booking_seat_flights
end