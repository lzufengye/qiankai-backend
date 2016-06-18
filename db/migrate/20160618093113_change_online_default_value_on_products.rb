class ChangeOnlineDefaultValueOnProducts < ActiveRecord::Migration
  def change
    change_column_default :products, :on_sale, false
  end
end
