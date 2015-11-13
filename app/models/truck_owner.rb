# == Schema Information
#
# Table name: truck_owners
#
#  id           :integer          not null, primary key
#  name         :string
#  phone_number :string
#  address      :string
#  id_number    :string
#  entity_type  :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class TruckOwner < ActiveRecord::Base
	has_many :trucks
	has_many :attachments
end
