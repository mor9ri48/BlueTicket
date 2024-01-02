class CreateAirports < ActiveRecord::Migration[7.0]
  def change
    create_table :airports do |t|
      t.string :name, null: false # 空港名

      t.timestamps
    end
  end
end