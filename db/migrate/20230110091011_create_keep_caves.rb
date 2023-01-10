class CreateKeepCaves < ActiveRecord::Migration[6.1]
  def change
    create_table :keep_caves do |t|
      t.integer :customer_id
      t.integer :cafe_id

      t.timestamps
    end
  end
end
