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
#

class Consignee < ActiveRecord::Base
  belongs_to :city
  belongs_to :account
	acts_as_tenant(:account)
end
