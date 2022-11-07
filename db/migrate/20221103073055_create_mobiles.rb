class CreateMobiles < ActiveRecord::Migration[7.0]
  def change
    create_table :mobiles do |t|
      t.string :brand_name
      t.string :ram
      t.string :rom
      t.string :price

      t.timestamps
    end
  end
end
