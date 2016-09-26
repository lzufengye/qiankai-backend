class AddQqNumberToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :qq_number, :string
  end
end
