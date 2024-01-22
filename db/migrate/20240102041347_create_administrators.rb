class CreateAdministrators < ActiveRecord::Migration[7.0]
  def change
    create_table :administrators do |t|
      t.string :name, null:false       # 管理者名
      t.string :login_name, null:false # ログイン名

      t.timestamps
    end
  end
end