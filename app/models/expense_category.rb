# == Schema Information
#
# Table name: expense_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ExpenseCategory < ApplicationRecord
	belongs_to :account
	acts_as_tenant(:account)
	has_many :expenses

	def total_expenses currency="", truck=nil, from="", to=""
		# binding.pry
		xps = expenses
		if !truck.blank?
			xps = expenses.where(truck_id: truck)
		end

		if !from.blank? && !to.blank?
			xps = xps.date_between(from, to)
		end

		if currency.blank?
			xps.collect{|x| x.amount}.compact.sum
		elsif currency == "US Dollar"
			xps.where(currency: "US Dollar").sum(:dollar_amount) 
		elsif currency == "Kenya Shilling"
			xps.where(currency: "Kenya Shilling").sum(:amount)
		end
	end
end
