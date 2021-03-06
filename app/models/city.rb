# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  name       :string
#  country    :string
#  city_type  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :integer
#

class City < ApplicationRecord
	belongs_to :account
	acts_as_tenant(:account)

	def trips
		Trip.where('depot_id = ? OR destination_id = ?', id, id)
	end
end
