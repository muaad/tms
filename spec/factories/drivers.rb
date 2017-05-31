# == Schema Information
#
# Table name: drivers
#
#  id           :integer          not null, primary key
#  name         :string
#  phone_number :string
#  address      :string
#  id_number    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :integer
#

FactoryGirl.define do
  factory :driver do
    name "MyString"
phone_number "MyString"
address "MyString"
id_number "MyString"
  end

end
