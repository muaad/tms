class Trip < ActiveRecord::Base
  belongs_to :truck
  belongs_to :driver
  belongs_to :turn_boy
  belongs_to :consignee
  belongs_to :product

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
