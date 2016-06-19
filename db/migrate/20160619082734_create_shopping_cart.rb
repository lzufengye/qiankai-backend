class CreateShoppingCart < ActiveRecord::Migration
  def change
    create_table :shopping_carts do |t|
      t.integer :consumer_id
      t.integer :product_id
      t.integer :sku_id
      t.integer :quantity
      t.timestamps
    end
  end
end
