class CreateTruckOwners < ActiveRecord::Migration
  def change
    create_table :truck_owners do |t|
      t.string :name
      t.string :phone_number
      t.string :address
      t.string :id_number
      t.string :entity_type

      t.timestamps null: false
    end
  end
end
