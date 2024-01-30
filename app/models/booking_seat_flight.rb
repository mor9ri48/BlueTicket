class BookingSeatFlight < ApplicationRecord
  # seat(多)←→booking(多)の関連付け
  belongs_to :seat
  belongs_to :booking
  # flight(多)←→seat(多)の関連付け
  belongs_to :flight, optional: true

  validates :passenger_name, presence: true
  validates :passenger_birthday, presence: true, comparison: { less_than: Time.current.to_date, allow_blank: true }
  validates :passenger_email, presence: true, email: { allow_blank: true }
  validates :passenger_telephone_number, presence: true,
            format: { with: /\A[0-9\-()]*\z/, allow_blank: true },
            length: { minimum: 8, maximum: 15, allow_blank: true }
end
