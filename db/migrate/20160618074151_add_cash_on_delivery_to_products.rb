class AddCashOnDeliveryToProducts < ActiveRecord::Migration
  def change
    add_column :products, :cash_on_delivery, :string, null: false, default: '支持货到付款'
  end
end
