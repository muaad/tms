class Notification < ActiveRecord::Base
	attr_accessor :attachment_name
  belongs_to :attachment

  belongs_to :account
  acts_as_tenant(:account)

  # scope :read, -> { where('read = ?', true) }
  # scope :resolved, -> { where('resolved = ?', true) }
  # scope :unread, -> { where('read = ?', false) }
  # scope :unresolved, -> { where('resolved = ?', false) }

  def attachment_and_owner
  	"#{attachment.name} - #{attachment.owner_name}"
  end

  def self.read
	  Notification.where(read: true)
	end

	def self.unread
	  Notification.where(read: false)
	end

	def self.resolved
	  Notification.where(resolved: true)
	end

	def self.unresolved
	  Notification.where(resolved: false)
	end
end
