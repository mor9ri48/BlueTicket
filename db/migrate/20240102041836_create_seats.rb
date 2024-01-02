class CreateSeats < ActiveRecord::Migration[7.0]
  def change
    create_table :seats do |t|
      t.references :airmodel            # 飛行機名
      t.string :number, null: false     # 番号
      t.string :seat_class, null: false # クラス
      t.integer :price, null: false     # 席の追加料金

      t.timestamps
    end
  end
end