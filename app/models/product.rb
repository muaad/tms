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

class Product < ApplicationRecord
	has_many :expenses
	belongs_to :account
	acts_as_tenant(:account)
end
