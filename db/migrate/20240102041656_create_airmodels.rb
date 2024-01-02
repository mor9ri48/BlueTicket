class CreateAirmodels < ActiveRecord::Migration[7.0]
  def change
    create_table :airmodels do |t|
      t.string :name, null: false           # 飛行機名
      t.integer :economy_nums, null: false  # エコノミークラスの席数
      t.integer :business_nums, null: false # ビジネスクラスの席数
      t.integer :first_nums, null: false    # ファーストクラスの席数

      t.timestamps
    end
  end
end