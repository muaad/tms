class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.references :truck, index: true, foreign_key: true
      t.references :driver, index: true, foreign_key: true
      t.references :turn_boy, index: true, foreign_key: true
      t.date :date
      t.integer :depot_id
      t.integer :destination_id
      t.references :consignee, index: true, foreign_key: true
      t.references :product, index: true, foreign_key: true
      t.integer :quantity
      t.float :rate
      t.float :amount
      t.float :commission
      t.float :short
      t.text :description
      t.string :currency

      t.timestamps null: false
    end
  end
end
