# == Schema Information
#
# Table name: turn_boys
#
#  id           :integer          not null, primary key
#  name         :string
#  phone_number :string
#  address      :string
#  id_number    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe TurnBoy, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
