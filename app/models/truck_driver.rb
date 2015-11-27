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

class TruckDriver < ActiveRecord::Base
  belongs_to :truck
  belongs_to :driver
  belongs_to :account
	acts_as_tenant(:account)
end
