class Document < ActiveRecord::Base
  belongs_to :driver
  belongs_to :turn_boy
  belongs_to :truck_owner
  belongs_to :truck

  attr_accessible :file
	has_attached_file :file#, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
end
