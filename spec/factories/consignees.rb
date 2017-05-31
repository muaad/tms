# == Schema Information
#
# Table name: consignees
#
#  id           :integer          not null, primary key
#  name         :string
#  phone_number :string
#  city_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :integer
#

FactoryGirl.define do
  factory :consignee do
    name "MyString"
phone_number "MyString"
city nil
  end

end
