# == Schema Information
#
# Table name: diesel_companies
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :integer
#

class DieselCompany < ApplicationRecord
	has_many :diesel_expenses
	belongs_to :account
	acts_as_tenant(:account)
end
