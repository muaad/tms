class CreateDieselExpenses < ActiveRecord::Migration
  def change
    create_table :diesel_expenses do |t|
      t.integer :litres
      t.references :diesel_company, index: true, foreign_key: true
      t.references :expense, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
