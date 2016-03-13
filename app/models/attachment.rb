# == Schema Information
#
# Table name: attachments
#
#  id                :integer          not null, primary key
#  name              :string
#  driver_id         :integer
#  turn_boy_id       :integer
#  truck_owner_id    :integer
#  truck_id          :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#

class Attachment < ActiveRecord::Base
	attr_accessor :long_name

  belongs_to :driver
  belongs_to :turn_boy
  belongs_to :truck_owner
  belongs_to :truck
  belongs_to :account

  acts_as_tenant(:account)

	has_attached_file :file, styles: { medium: "300x300>", thumb: "100x100>" }#, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

	def owner_details
		if !driver_id.nil?
			owner = driver
			owner_type = 'driver'
		end
		if !turn_boy_id.nil?
			owner = turn_boy
			owner_type = 'turn_boy'
		end
		if !truck_owner_id.nil?
			owner = truck_owner
			owner_type = 'truck_owner'
		end
		if !truck_id.nil?
			owner = truck
			owner_type = 'truck'
		end
		{owner: owner, owner_type: owner_type}
	end

	def owner_name
		owner_details[:owner].name if !owner_details[:owner].nil?
	end

	def owner_url
		url = ''
		oid = owner_details[:owner].id if !owner_details[:owner].nil?
		url = "#{owner_details[:owner_type]}s/#{oid}" if !oid.blank?
	end

	def self.expiring_in period
		Attachment.unexpired.where('date_of_expiry <= ?', period.from_now)
	end

	def self.expired
		Attachment.where('date_of_expiry <= ?', Time.now)
	end

	def self.unexpired
		Attachment.where('date_of_expiry > ?', Time.now)
	end
end
