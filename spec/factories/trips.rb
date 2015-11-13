# == Schema Information
#
# Table name: trips
#
#  id             :integer          not null, primary key
#  truck_id       :integer
#  driver_id      :integer
#  turn_boy_id    :integer
#  date           :date
#  depot_id       :integer
#  destination_id :integer
#  consignee_id   :integer
#  product_id     :integer
#  quantity       :integer
#  rate           :float
#  amount         :float
#  commission     :float
#  short          :float
#  description    :text
#  currency       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryGirl.define do
  factory :trip do
    truck nil
driver nil
turn_boy nil
date "2015-11-03"
depot_id 1
destination_id 1
consignee nil
product nil
quantity 1
rate 1.5
amount 1.5
commission 1.5
short 1.5
description "MyText"
currency "MyString"
  end

end
