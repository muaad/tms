class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :attachment, index: true, foreign_key: true
      t.string :notification_type
      t.boolean :read, default: false
      t.boolean :resolved, default: false

      t.timestamps null: false
    end
  end
end
