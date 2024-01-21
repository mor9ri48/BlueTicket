class CreateAirlines < ActiveRecord::Migration[7.0]
  def change
    create_table :airlines do |t|
      t.string :name, null:false       # 航空会社名
      t.string :login_name, null:false # ログイン名

      t.timestamps
    end
  end
end