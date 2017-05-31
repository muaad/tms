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

class TruckCash < ApplicationRecord
	include Reportable
  belongs_to :truck
end
