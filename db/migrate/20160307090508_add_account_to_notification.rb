class AddAccountToNotification < ActiveRecord::Migration
  def change
    add_reference :notifications, :account, index: true, foreign_key: true
  end
end
