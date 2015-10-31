class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.boolean :active, default: false

      t.timestamps null: false
    end
  end
end
