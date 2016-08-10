class AddPhoneToTourism < ActiveRecord::Migration
  def change
    add_column :tourisms, :phone, :string
  end
end
