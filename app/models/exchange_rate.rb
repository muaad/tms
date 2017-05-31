# == Schema Information
#
# Table name: exchange_rates
#
#  id           :integer          not null, primary key
#  currency_one :string
#  currency_two :string
#  rate         :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :integer
#

class ExchangeRate < ApplicationRecord
	belongs_to :account
	acts_as_tenant(:account)
end
