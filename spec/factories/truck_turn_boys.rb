# == Schema Information
#
# Table name: truck_turn_boys
#
#  id          :integer          not null, primary key
#  truck_id    :integer
#  turn_boy_id :integer
#  active      :boolean
#  salary      :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  account_id  :integer
#

FactoryGirl.define do
  factory :truck_turn_boy do
    truck nil
turn_boy nil
active false
salary 1.5
  end

end
