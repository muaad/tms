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

require 'rails_helper'

RSpec.describe TruckDriver, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
