class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false             # 名前
      t.string :alph_name, null: false        # アルファベット名
      t.string :login_name, null: false       # ログイン名
      t.integer :sex, null: false, default: 1 # 性別(1:男性, 2:女性)
      t.date :birthday, null: false           # 生年月日
      t.string :email, null: false            # メールアドレス

      t.timestamps
    end
  end
end