# == Schema Information
#
# Table name: truck_cashes
#
#  id          :integer          not null, primary key
#  truck_id    :integer
#  amount      :float
#  date        :date
#  lpo         :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  direction   :string           default("IN")
#  currency    :string
#

FactoryGirl.define do
  factory :truck_cash do
    truck nil
amount 1.5
date "2015-12-06"
lpo "MyString"
description "MyText"
  end

end
