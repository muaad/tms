class CreateTruckDrivers < ActiveRecord::Migration
  def change
    create_table :truck_drivers do |t|
      t.references :truck, index: true, foreign_key: true
      t.references :driver, index: true, foreign_key: true
      t.boolean :active, default: false
      t.float :salary

      t.timestamps null: false
    end
  end
end
