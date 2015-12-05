class AddFieldsToCash < ActiveRecord::Migration
  def change
    add_column :cashes, :lpo, :string
    add_column :cashes, :description, :text
  end
end
