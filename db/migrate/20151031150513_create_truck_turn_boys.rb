class CreateTruckTurnBoys < ActiveRecord::Migration
  def change
    create_table :truck_turn_boys do |t|
      t.references :truck, index: true, foreign_key: true
      t.references :turn_boy, index: true, foreign_key: true
      t.boolean :active
      t.float :salary

      t.timestamps null: false
    end
  end
end
