class Driver < ActiveRecord::Base
	has_many :truck_drivers
	has_many :trucks, through: :truck_drivers
	has_many :expenses

	def truck
		t = nil
		t = truck_drivers.where(active: true).first.truck if !truck_drivers.where(active: true).first.nil?
	end
end
