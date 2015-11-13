class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :name
      t.references :driver, index: true, foreign_key: true
      t.references :turn_boy, index: true, foreign_key: true
      t.references :truck_owner, index: true, foreign_key: true
      t.references :truck, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
