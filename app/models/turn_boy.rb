class TurnBoy < ActiveRecord::Base
	has_many :truck_turn_boys
	has_many :trucks, through: :truck_turn_boys
	has_many :expenses

	def truck
		t = nil
		t = truck_turn_boys.where(active: true).first.truck if !truck_turn_boys.where(active: true).first.nil?
	end
end
