class AddCurrencyToTruckCash < ActiveRecord::Migration
  def change
    add_column :truck_cashes, :currency, :string
  end
end
