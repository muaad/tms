class TruckCash < ActiveRecord::Base
	include Reportable
  belongs_to :truck
end
