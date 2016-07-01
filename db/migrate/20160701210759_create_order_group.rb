class CreateOrderGroup < ActiveRecord::Migration
  def change
    create_table :order_groups do |t|
      t.text :order_sns
      t.timestamps
    end
  end
end
