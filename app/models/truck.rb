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

	include Reportable

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

	def cash from="", to=""
		if from.blank? || to.blank?
			c = truck_cashes
		else
			c = truck_cashes.date_between(from, to)
		end
		c
	end

	def cash_in currency="", from="", to=""
		if !currency.blank?
			cash(from, to).where(direction: "IN", currency: currency)
		else
			cash(from, to).where(direction: "IN")
		end
	end

	def cash_out currency="", from="", to=""
		if !currency.blank?
			cash(from, to).where(direction: "OUT", currency: currency)
		else
			cash(from, to).where(direction: "OUT")
		end
	end

	def total_cash_in currency="", from="", to=""
		if !currency.blank?
			cash_in(currency, from, to).sum(:amount)
		else
			cash_in(from, to).sum(:amount)
		end
	end

	def total_cash_out currency="", from="", to=""
		if !currency.blank?
			cash_out(currency, from, to).sum(:amount)
		else
			cash_out(from, to).sum(:amount)
		end
	end

	def name
		registration_number
	end

	def trps from="", to=""
		trs = trips
		trs = trips.date_between(from, to) if !from.blank? && !to.blank?
		trs
	end

	def income currency="", from="", to=""
		if !currency.blank?
			trps(from, to).where(currency: currency).sum(:amount)
		else
			trps(from, to).sum(:amount)
		end
	end

	def dollar_income from="", to=""
		trps(from, to).where(currency: "US Dollar").sum(:amount)
	end

	def shilling_income from="", to=""
		trps(from, to).where(currency: "Kenya Shilling").sum(:amount)
	end

	def total_income currency="", from="", to=""
		if !currency.blank?
			income(currency, from, to) + total_cash_in(currency, from, to)
		else
			income(from, to) + total_cash_in(currency, from, to)
		end
	end

	def xps from="", to=""
		x = expenses
		x = expenses.date_between(from, to) if !from.blank? && !to.blank?
		x
	end

	def total_expenses currency="", from="", to=""
		tx = 0.0
		if !currency.blank?
			tx = xps(from, to).where(currency: currency).sum(:amount) if currency == "Kenya Shilling"
			tx = xps(from, to).where(currency: currency).sum(:dollar_amount) if currency == "US Dollar"
		else
			tx = xps(from, to).sum(:amount)
		end
		tx
	end

	def balance currency="", from="", to=""
		if !currency.blank?
			total_income(currency) - (total_expenses(currency) + total_cash_out(currency))
		else
			total_income - (total_expenses + total_cash_out)
		end
	end
end
