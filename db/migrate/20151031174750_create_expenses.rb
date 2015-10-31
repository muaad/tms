class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.references :expense_category, index: true, foreign_key: true
      t.float :amount
      t.references :product, index: true, foreign_key: true
      t.references :driver, index: true, foreign_key: true
      t.references :truck, index: true, foreign_key: true
      t.references :turn_boy, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :description
      t.string :lpo

      t.timestamps null: false
    end
  end
end
