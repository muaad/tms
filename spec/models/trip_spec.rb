# == Schema Information
#
# Table name: trips
#
#  id             :integer          not null, primary key
#  truck_id       :integer
#  driver_id      :integer
#  turn_boy_id    :integer
#  date           :date
#  depot_id       :integer
#  destination_id :integer
#  consignee_id   :integer
#  product_id     :integer
#  quantity       :integer
#  rate           :float
#  amount         :float
#  commission     :float
#  short          :float
#  description    :text
#  currency       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Trip, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
