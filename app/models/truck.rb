# == Schema Information
#
# Table name: trucks
#
#  id                  :integer          not null, primary key
#  registration_number :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  truck_owner_id      :integer
#

class Truck < ActiveRecord::Base
	attr_accessor :driver_salary
	attr_accessor :turn_boy_salary

	belongs_to :truck_owner
	has_many :truck_drivers
	has_many :drivers, through: :truck_drivers
	has_many :truck_turn_boys
	has_many :turn_boys, through: :truck_turn_boys
	has_many :expenses
	has_many :trips
	has_many :attachments
	belongs_to :account
	acts_as_tenant(:account)

	def driver
		d = truck_drivers.where(active: true).first.driver if !truck_drivers.where(active: true).first.nil?
		# d.salary = d.calculate_salary(self)
		d
	end

	def calculate_driver_salary
		driver.calculate_salary(self)
	end

	def turn_boy
		truck_turn_boys.where(active: true).first.turn_boy if !truck_turn_boys.where(active: true).first.nil?
	end

	def calculate_turn_boy_salary
		turn_boy.calculate_salary(self)
	end

	def owner
		truck_owner
	end

	def name
		registration_number
	end

	def income
		trips.sum(:amount)
	end

	def dollar_income
		trips.where(currency: "US Dollar").sum(:amount)
	end

	def shilling_income
		trips.where(currency: "Kenya Shilling").sum(:amount)
	end

	def total_expenses
		expenses.sum(:amount)
	end

	def balance
		income - total_expenses
	end
end
