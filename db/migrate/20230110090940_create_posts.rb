class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :customer_id
      t.integer :cafe_id
      t.text :body
      t.timestamps
    end
  end
end
