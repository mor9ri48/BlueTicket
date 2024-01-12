class CreateBookingSeatFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :booking_seat_flights do |t|
      t.references :booking # 外部キー
      t.references :seat    # 外部キー
      t.references :flight  # 外部キー
      # 搭乗者
      t.string :passenger_name, null: false             # 名前
      t.date :passenger_birthday, null: false           # 生年月日
      t.string :passenger_email, null: false            # メールアドレス
      t.string :passenger_telephone_number, null: false # 電話番号
      t.boolean :checkin, null: false, default: false   # チェックイン判定

      t.timestamps
    end
  end
end