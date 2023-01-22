class CreateCaves < ActiveRecord::Migration[6.1]
  def change
    create_table :caves do |t|
      t.string :name, null: false
      t.string :prefectures, null: false
      t.string :address_after, null: false
      t.string :nearest_station, null: false
      t.string :telephone_number, null: false
      t.string :business_hours, null: false
      t.string :regular_holiday, null: false
      t.float :rate
      t.boolean :is_deleted, null: false, default: false

      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
