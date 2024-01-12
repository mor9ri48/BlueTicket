class Airmodel < ApplicationRecord
  # airmodel(1)←→flight(多)の関連付け
  has_many :flights
  # airmodel(1)←→seat(多)の関連付け
  has_many :seats
end