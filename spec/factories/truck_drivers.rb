# == Schema Information
#
# Table name: truck_drivers
#
#  id         :integer          not null, primary key
#  truck_id   :integer
#  driver_id  :integer
#  active     :boolean          default(FALSE)
#  salary     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :truck_driver do
    truck nil
driver nil
active false
salary 1.5
  end

end
