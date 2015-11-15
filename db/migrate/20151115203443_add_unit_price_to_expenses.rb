class AddUnitPriceToExpenses < ActiveRecord::Migration
  def change
    add_column :expenses, :unit_price, :float
  end
end
