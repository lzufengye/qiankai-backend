class AddRankToAdvertisement < ActiveRecord::Migration
  def change
    add_column :advertisements, :rank, :integer, null: false, default: 0
  end
end
