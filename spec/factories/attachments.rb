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

FactoryGirl.define do
  factory :attachment do
    name "MyString"
driver nil
turn_boy nil
truck_owner nil
truck nil
  end

end
