class SetDefaultForExpenseCurrency < ActiveRecord::Migration
  def change
  	change_column :expenses, :currency, :string, default: "Kenya Shilling"
  end
end
