# == Schema Information
#
# Table name: products
#
#  id           :integer          not null, primary key
#  name         :string
#  price        :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_type :string
#  account_id   :integer
#

FactoryGirl.define do
  factory :product do
    name "MyString"
price 1.5
  end

end
