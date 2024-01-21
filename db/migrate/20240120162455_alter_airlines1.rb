class AlterAirlines1 < ActiveRecord::Migration[7.0]
  def change
    add_column :airlines, :password_digest, :string
  end
end
