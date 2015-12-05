class CreateCashes < ActiveRecord::Migration
  def change
    create_table :cashes do |t|
      t.date :date
      t.float :amount_in
      t.float :amount_out
      t.float :balance
      t.boolean :closed, default: false

      t.timestamps null: false
    end
  end
end
