class CreateHotel < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name, null: false
      t.string :description
      t.string :phone
      t.timestamps null: false
    end
  end
end
