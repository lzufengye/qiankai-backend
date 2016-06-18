class AddSoldNumberToProducts < ActiveRecord::Migration
  def change
    add_column :products, :sold_number, :integer, null: false, default: 0
  end
end
