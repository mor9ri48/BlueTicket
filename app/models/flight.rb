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

  # バリデーション
  # 機体名
  validates :name, presence: true, length: { maximum: 20 }

  # 出発地・到着地
  validates :destination_id, comparison: { other_than: :origin_id }

  # 出発日・到着日(過去の便も予約するために一時的にコメントアウトをしている)
  # validates :departure_date, comparison: { greater_than: Time.current.to_date }
  # validates :arrival_date, comparison: { greater_than: Time.current.to_date }

  # 出発日・到着日(過去の便も予約するために一時的にコメントアウトをしている)
  # validates :departure_time, comparison: { less_than_or_equal_to: :arrival_time }
  # validates :arrival_time, comparison: { greater_than_or_equal_to: :departure_time }

  # 便の検索
  class << self
    def search(origin, destination, date, time, movement, seat_class, minPrice, maxPrice)
      rel = order("id")
      if origin.present? && destination.present?
        rel = rel.where(origin_id: origin, destination_id: destination)
      end

      # 出発・到着の日時指定
      if date.present? && time.present? && movement.present?
        if movement == "出発"
          rel = rel.where("departure_date = ?", date)
          rel = rel.where("departure_time <= ?", "2000-01-01 #{time}")
        elsif movement == "到着"
          rel = rel.where("arrival_date = ?", date)
          rel = rel.where("arrival_time >= ?", "2000-01-01 #{time}")
        end
      end  

      # 残り座席数の確認
      if seat_class == "first"
        seatPrice = Seat.find_by("seat_class = ?", "first").price; 
      elsif seat_class == "business"
        seatPrice = Seat.find_by("seat_class = ?", "business").price; 
      elsif seat_class == "economy"
        seatPrice = Seat.find_by("seat_class = ?", "economy").price; 
      else
        seatPrice = Seat.find_by("seat_class = ?", "economy").price; 
      end

      # 料金の確認
      if minPrice.present?
        minPrice = minPrice.to_i - seatPrice
        rel = rel.where("price >= ?", minPrice)
      end
      if maxPrice.present?
        max = maxPrice.to_i - seatPrice
        rel = rel.where("price <= ?", maxPrice)
      end
      rel
    end
  end
end
