# == Schema Information
#
# Table name: cashes
#
#  id          :integer          not null, primary key
#  date        :date
#  amount_in   :float
#  amount_out  :float
#  balance     :float
#  closed      :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lpo         :string
#  description :text
#  account_id  :integer
#

FactoryGirl.define do
  factory :cash do
    date "2015-12-04"
amount_in 1.5
amount_out 1.5
balance 1.5
closed false
  end

end
