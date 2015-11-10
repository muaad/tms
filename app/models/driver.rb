class Driver < ActiveRecord::Base
	attr_accessor :salary
	has_many :truck_drivers
	has_many :trucks, through: :truck_drivers
	has_many :expenses
	has_many :documents

	def truck
		t = nil
		t = truck_drivers.where(active: true).first.truck if !truck_drivers.where(active: true).first.nil?
	end

	def calculate_salary truck
		sal = nil
		t = truck_drivers.where(truck: truck).first
		sal = t.salary if !t.nil?
	end
end
