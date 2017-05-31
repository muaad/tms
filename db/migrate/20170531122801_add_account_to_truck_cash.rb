class AddAccountToTruckCash < ActiveRecord::Migration[5.0]
  def change
    add_reference :truck_cashes, :account, foreign_key: true
    add_reference :exchange_rates, :account, foreign_key: true
  end
end
