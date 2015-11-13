# == Schema Information
#
# Table name: trucks
#
#  id                  :integer          not null, primary key
#  registration_number :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  truck_owner_id      :integer
#

FactoryGirl.define do
  factory :truck do
    registration_number "MyString"
  end

end
