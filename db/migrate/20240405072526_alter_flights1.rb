class AlterFlights1 < ActiveRecord::Migration[7.0]
  def change
    change_column :flights, :departure_time, :datetime, null: false # 出発時間
    change_column :flights, :arrival_time, :datetime, null: false   # 到着時間
  end
end
