class Truck < ActiveRecord::Base
	belongs_to :truck_owner
	has_many :truck_drivers
	has_many :drivers, through: :truck_drivers

	def driver
		drivers.where(active: true).first
	end
end
