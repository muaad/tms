# == Schema Information
#
# Table name: diesel_companies
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :diesel_company do
    name "MyString"
price 1.5
  end

end
