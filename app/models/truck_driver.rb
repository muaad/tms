class TruckDriver < ActiveRecord::Base
  belongs_to :truck
  belongs_to :driver
end
