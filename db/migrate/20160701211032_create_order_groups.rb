class CreateOrderGroups < ActiveRecord::Migration
  def change
    create_table :order_groups do |t|

      t.timestamps null: false
    end
  end
end
