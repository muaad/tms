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

require 'rails_helper'

RSpec.describe ExchangeRate, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
