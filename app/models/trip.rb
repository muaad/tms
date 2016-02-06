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

class Trip < ActiveRecord::Base
  include Reportable

  belongs_to :truck
  belongs_to :driver
  belongs_to :turn_boy
  belongs_to :consignee
  belongs_to :product
  belongs_to :account
  acts_as_tenant(:account)

  def depot
  	City.find(depot_id)
  end

  def destination
  	City.find(destination_id)
  end

  def name
  	"#{truck.registration_number} - #{date} - #{destination.name}"
  end
end
