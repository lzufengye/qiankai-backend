class AddArchiveToProducts < ActiveRecord::Migration
  def change
    add_column :products, :archive, :boolean, default: false, null: false
  end
end
