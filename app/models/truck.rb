class Truck < ActiveRecord::Base
	belongs_to :truck_owner
	has_many :truck_drivers
	has_many :drivers, through: :truck_drivers
	has_many :truck_turn_boys
	has_many :turn_boys, through: :truck_turn_boys
	has_many :expenses

	def driver
		truck_drivers.where(active: true).first.driver if !truck_drivers.where(active: true).first.nil?
	end

	def turn_boy
		truck_turn_boys.where(active: true).first.turn_boy if !truck_turn_boys.where(active: true).first.nil?
	end

	def owner
		truck_owner
	end
end
