# == Schema Information
#
# Table name: truck_turn_boys
#
#  id          :integer          not null, primary key
#  truck_id    :integer
#  turn_boy_id :integer
#  active      :boolean
#  salary      :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class TruckTurnBoy < ApplicationRecord
  belongs_to :truck
  belongs_to :turn_boy
  belongs_to :account
	acts_as_tenant(:account)
end
