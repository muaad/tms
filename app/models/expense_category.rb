# == Schema Information
#
# Table name: expense_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ExpenseCategory < ActiveRecord::Base
	belongs_to :account
	acts_as_tenant(:account)
	has_many :expenses

	def total_expenses currency="", truck=nil
		# binding.pry
		xps = self.expenses
		if !truck.blank?
			xps = self.expenses.where(truck_id: truck)
		end

		if currency.blank?
			xps.collect{|x| x.amount}.compact.sum
		elsif currency == "US Dollar"
			xps.dollar.collect{|x| x.dollar_amount}.compact.sum 
		elsif currency == "Kenya Shilling"
			xps.shilling.collect{|x| x.amount}.compact.sum
		end
	end
end
