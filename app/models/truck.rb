class Truck < ActiveRecord::Base
	belongs_to :truck_owner
	has_many :truck_drivers
	has_many :drivers, through: :truck_drivers
	has_many :truck_turn_boys
	has_many :turn_boys, through: :truck_turn_boys
	has_many :expenses

	def driver
		drivers.where(active: true).first
	end

	def turn_boy
		turn_boys.where(active: true).first
	end
end
