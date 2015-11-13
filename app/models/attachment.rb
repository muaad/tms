# == Schema Information
#
# Table name: attachments
#
#  id                :integer          not null, primary key
#  name              :string
#  driver_id         :integer
#  turn_boy_id       :integer
#  truck_owner_id    :integer
#  truck_id          :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  file_file_name    :string
#  file_content_type :string
#  file_file_size    :integer
#  file_updated_at   :datetime
#

class Attachment < ActiveRecord::Base
  belongs_to :driver
  belongs_to :turn_boy
  belongs_to :truck_owner
  belongs_to :truck

	has_attached_file :file, styles: { medium: "300x300>", thumb: "100x100>" }#, default_url: "/images/:style/missing.png"
	validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/
end
