class BookingSeatFlight < ApplicationRecord
  # seat(多)←→booking(多)の関連付け
  belongs_to :seat
  belongs_to :booking
  # flight(多)←→seat(多)の関連付け
  belongs_to :flight, optional: true
end
