class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :customer                # 予約したお客さんの外部キー
      t.references :flight                  # 予約した便の外部キー
      t.references :booking_seat_flight     # 外部キー
      t.integer :total_price, null: false   # 予約時の合計料金
      t.string :payment_method, null: false # 決済方法

      t.timestamps
    end
  end
end