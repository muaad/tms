class AddTruckOwnerToTruck < ActiveRecord::Migration
  def change
    add_reference :trucks, :truck_owner, index: true, foreign_key: true
  end
end
