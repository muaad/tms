class CreateTruckCashes < ActiveRecord::Migration
  def change
    create_table :truck_cashes do |t|
      t.references :truck, index: true, foreign_key: true
      t.float :amount
      t.date :date
      t.string :lpo
      t.text :description

      t.timestamps null: false
    end
  end
end
