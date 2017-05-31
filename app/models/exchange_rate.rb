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
#

class ExchangeRate < ApplicationRecord
end
