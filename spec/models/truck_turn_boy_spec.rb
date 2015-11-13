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

require 'rails_helper'

RSpec.describe TruckTurnBoy, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
