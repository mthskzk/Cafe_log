class CreateCaves < ActiveRecord::Migration[6.1]
  def change
    create_table :caves do |t|
      t.string :name, null: false
      t.string :prefectures
      t.string :address_after
      t.string :nearest_station
      t.string :telephone_number
      t.string :business_hours
      t.string :regular_holiday
      t.float :rate
      t.boolean :is_deleted, null: false, default: false

      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
