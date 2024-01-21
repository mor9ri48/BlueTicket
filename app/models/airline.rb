class Airline < ApplicationRecord
  has_secure_password
  # airline(1)←→flight(多)の関連付け
  has_many :flights
end