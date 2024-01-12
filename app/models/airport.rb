class Airport < ApplicationRecord
    # airport(1)←→flight(多)の関連付け
    has_many :origin, class_name: "Flight", foreign_key: "origin_id"
    has_many :destination, class_name: "Flight", foreign_key: "destination_id"
end
