class Trip < ActiveRecord::Base
  belongs_to :truck
  belongs_to :driver
  belongs_to :turn_boy
  belongs_to :consignee
  belongs_to :product
end
