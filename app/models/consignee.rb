# == Schema Information
#
# Table name: consignees
#
#  id           :integer          not null, primary key
#  name         :string
#  phone_number :string
#  city_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :integer
#

class Consignee < ApplicationRecord
  belongs_to :city
  has_many :trips
  belongs_to :account
		acts_as_tenant(:account)
end
