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
	has_many :truck_cashes
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

	def cash
		truck_cashes
	end

	def cash_in currency=""
		if !currency.blank?
			cash.where(direction: "IN", currency: currency)
		else
			cash.where(direction: "IN")
		end
	end

	def cash_out currency=""
		if !currency.blank?
			cash.where(direction: "OUT", currency: currency)
		else
			cash.where(direction: "OUT")
		end
	end

	def total_cash_in currency=""
		if !currency.blank?
			cash_in(currency).sum(:amount)
		else
			cash_in.sum(:amount)
		end
	end

	def total_cash_out currency=""
		if !currency.blank?
			cash_out(currency).sum(:amount)
		else
			cash_out.sum(:amount)
		end
	end

	def name
		registration_number
	end

	def income currency=""
		if !currency.blank?
			trips.where(currency: currency).sum(:amount)
		else
			trips.sum(:amount)
		end
	end

	def dollar_income
		trips.where(currency: "US Dollar").sum(:amount)
	end

	def shilling_income
		trips.where(currency: "Kenya Shilling").sum(:amount)
	end

	def total_income currency=""
		if !currency.blank?
			income(currency) + total_cash_in(currency)
		else
			income + total_cash_in(currency)
		end
	end

	def total_expenses currency=""
		tx = 0.0
		if !currency.blank?
			tx = expenses.where(currency: currency).sum(:amount) if currency == "Kenya Shilling"
			tx = expenses.where(currency: currency).sum(:dollar_amount) if currency == "US Dollar"
		else
			tx = expenses.sum(:amount)
		end
		tx
	end

	def balance currency=""
		if !currency.blank?
			total_income(currency) - (total_expenses(currency) + total_cash_out(currency))
		else
			total_income - (total_expenses + total_cash_out)
		end
	end
end
