class CreateAirmodels < ActiveRecord::Migration[7.0]
  def change
    create_table :airmodels do |t|
      t.string :name, null: false           # 機体名
      t.integer :economy_nums, null: false  # エコノミークラス席数
      t.integer :business_nums, null: false # ビジネスクラス席数
      t.integer :first_nums, null: false    # ファーストクラス席数

      t.timestamps
    end
  end
end