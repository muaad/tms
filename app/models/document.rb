class Document < ActiveRecord::Base
  belongs_to :driver
  belongs_to :turn_boy
  belongs_to :truck_owner
  belongs_to :truck
end
