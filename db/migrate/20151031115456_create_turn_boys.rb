class CreateTurnBoys < ActiveRecord::Migration
  def change
    create_table :turn_boys do |t|
      t.string :name
      t.string :phone_number
      t.string :address
      t.string :id_number

      t.timestamps null: false
    end
  end
end
