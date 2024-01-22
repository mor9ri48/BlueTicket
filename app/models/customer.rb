class Customer < ApplicationRecord
  # customer(1)←→booking(多)の関連付け
  has_many :bookings, dependent: :destroy

  # 顧客検索
  class << self
    def search(query)
      rel = order("id")
      if query.present?
        rel = rel.where("login_name LIKE ? OR name LIKE ? OR alph_name LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
      end
      rel
    end
  end
end
