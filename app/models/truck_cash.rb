class TruckCash < ApplicationRecord
	include Reportable
  belongs_to :truck
end
