# == Schema Information
#
# Table name: truck_cashes
#
#  id          :integer          not null, primary key
#  truck_id    :integer
#  amount      :float
#  date        :date
#  lpo         :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  direction   :string           default("IN")
#  currency    :string
#

require 'rails_helper'

RSpec.describe TruckCash, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
