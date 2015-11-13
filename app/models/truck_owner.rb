class TruckOwner < ActiveRecord::Base
	has_many :trucks
	has_many :attachments
end
