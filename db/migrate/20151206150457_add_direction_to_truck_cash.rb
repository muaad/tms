class AddDirectionToTruckCash < ActiveRecord::Migration
  def change
    add_column :truck_cashes, :direction, :string, default: "IN"
  end
end
