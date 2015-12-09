class AddMileageToTrip < ActiveRecord::Migration
  def change
    add_column :trips, :mileage, :float
  end
end
