class AddAccountToCash < ActiveRecord::Migration
  def change
    add_reference :cashes, :account, index: true, foreign_key: true
  end
end
