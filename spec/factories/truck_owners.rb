# == Schema Information
#
# Table name: truck_owners
#
#  id           :integer          not null, primary key
#  name         :string
#  phone_number :string
#  address      :string
#  id_number    :string
#  entity_type  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :truck_owner do
    name "MyString"
phone_number "MyString"
address "MyString"
id_number "MyString"
entity_type "MyString"
  end

end
