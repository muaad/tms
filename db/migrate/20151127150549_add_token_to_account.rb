class AddTokenToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :token, :string
  end
end
