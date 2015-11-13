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

require 'rails_helper'

RSpec.describe Attachment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
