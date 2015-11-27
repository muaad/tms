class AddAccountToModels < ActiveRecord::Migration
  def change
    add_reference :attachments, :account, index: true, foreign_key: true
    add_reference :cities, :account, index: true, foreign_key: true
    add_reference :consignees, :account, index: true, foreign_key: true
    add_reference :diesel_companies, :account, index: true, foreign_key: true
    add_reference :diesel_expenses, :account, index: true, foreign_key: true
    add_reference :drivers, :account, index: true, foreign_key: true
    add_reference :expenses, :account, index: true, foreign_key: true
    add_reference :expense_categories, :account, index: true, foreign_key: true
    add_reference :products, :account, index: true, foreign_key: true
    add_reference :trips, :account, index: true, foreign_key: true
    add_reference :trucks, :account, index: true, foreign_key: true
    add_reference :truck_drivers, :account, index: true, foreign_key: true
    add_reference :truck_owners, :account, index: true, foreign_key: true
    add_reference :truck_turn_boys, :account, index: true, foreign_key: true
    add_reference :turn_boys, :account, index: true, foreign_key: true
    add_reference :users, :account, index: true, foreign_key: true
  end
end
