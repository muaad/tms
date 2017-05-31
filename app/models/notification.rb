# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  attachment_id     :integer
#  notification_type :string
#  read              :boolean          default(FALSE)
#  resolved          :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :integer
#

class Notification < ApplicationRecord
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
