class CreateSeats < ActiveRecord::Migration[7.0]
  def change
    create_table :seats do |t|
      t.references :airmodel             # 機体の外部キー
      t.string :number, null: false      # 席数
      t.string :seat_class, null: false  # 席のクラス(種類)
      t.integer :price, null: false      # 席料金

      t.timestamps
    end
  end
end