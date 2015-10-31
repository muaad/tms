class Driver < ActiveRecord::Base
	has_many :truck_drivers
	has_many :trucks, through: :truck_drivers
	has_many :expenses

	def truck
		trucks.where(active: true).first
	end
end
