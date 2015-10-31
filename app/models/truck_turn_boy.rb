class TruckTurnBoy < ActiveRecord::Base
  belongs_to :truck
  belongs_to :turn_boy
end
