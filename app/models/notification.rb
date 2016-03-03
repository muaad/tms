class Notification < ActiveRecord::Base
	attr_accessor :attachment_name
  belongs_to :attachment

  scope :read, -> { where('read = ?', true) }
  scope :resolved, -> { where('resolved = ?', true) }
  scope :unread, -> { where('read = ?', false) }
  scope :unresolved, -> { where('resolved = ?', false) }

  def attachment_and_owner
  	"#{attachment.name} - #{attachment.owner_name}"
  end
end
