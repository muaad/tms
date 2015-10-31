class TurnBoy < ActiveRecord::Base
	has_many :truck_turn_boys
	has_many :trucks, through: :truck_turn_boys
end
