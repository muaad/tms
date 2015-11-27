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
	has_many :expenses
	belongs_to :account
	acts_as_tenant(:account)
end
