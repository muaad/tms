class AddFieldsToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :date_of_issue, :date
    add_column :attachments, :date_of_expiry, :date
  end
end
