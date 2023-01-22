class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :customer_id
      t.integer :cafe_id
      t.text :body
      t.float :rate
      t.timestamps
    end
  end
end
