class CreateFlights < ActiveRecord::Migration[7.0]
  def change
    create_table :flights do |t|
      t.string :name, null: false                       # 便の名前
      t.references :airline, null: false                # 運行する会社の外部キー
      t.references :airmodel, null: false               # 運行するモデルの外部キー
      t.date :departure_date, null: false               # 出発日
      t.time :departure_time, null: false               # 出発時間
      t.date :arrival_date, null: false                 # 到着日
      t.time :arrival_time, null: false                 # 到着時間
      t.references :origin, null: false                 # 出発地の外部キー
      t.references :destination, null: false            # 到着地の外部キー
      t.boolean :operation, null: false, default: true  # 運航(true)/欠航(false)
      t.integer :price, null: false                     # 運賃

      t.timestamps
    end
  end
end