# == Schema Information
#
# Table name: turn_boys
#
#  id           :integer          not null, primary key
#  name         :string
#  phone_number :string
#  address      :string
#  id_number    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :turn_boy do
    name "MyString"
phone_number "MyString"
address "MyString"
id_number "MyString"
  end

end
