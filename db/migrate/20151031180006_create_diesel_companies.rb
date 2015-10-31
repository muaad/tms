class CreateDieselCompanies < ActiveRecord::Migration
  def change
    create_table :diesel_companies do |t|
      t.string :name
      t.float :price

      t.timestamps null: false
    end
  end
end
