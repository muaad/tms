class AddDollarAmountToExpense < ActiveRecord::Migration
  def change
    add_column :expenses, :dollar_amount, :float
  end
end
