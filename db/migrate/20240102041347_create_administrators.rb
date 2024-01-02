class CreateAdministrators < ActiveRecord::Migration[7.0]
  def change
    create_table :administrators do |t|
      t.string :name, null:false                 # 名前
      t.string :login_name, null:false           # ログイン名
      t.string :password, null:false             # パスワード
      t.string :password_confimation, null:false # 確認用パスワード

      t.timestamps
    end
  end
end