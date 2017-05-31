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

FactoryGirl.define do
  factory :exchange_rate do
    currency_one "MyString"
currency_two "MyString"
rate 1.5
  end

end
