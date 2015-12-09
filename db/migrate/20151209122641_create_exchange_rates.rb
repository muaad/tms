class CreateExchangeRates < ActiveRecord::Migration
  def change
    create_table :exchange_rates do |t|
      t.string :currency_one
      t.string :currency_two
      t.float :rate

      t.timestamps null: false
    end
  end
end
