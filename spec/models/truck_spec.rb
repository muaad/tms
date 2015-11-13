# == Schema Information
#
# Table name: trucks
#
#  id                  :integer          not null, primary key
#  registration_number :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  truck_owner_id      :integer
#

require 'rails_helper'

RSpec.describe Truck, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
