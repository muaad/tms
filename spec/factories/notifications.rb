# == Schema Information
#
# Table name: notifications
#
#  id                :integer          not null, primary key
#  attachment_id     :integer
#  notification_type :string
#  read              :boolean          default(FALSE)
#  resolved          :boolean          default(FALSE)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :integer
#

FactoryGirl.define do
  factory :notification do
    attachment nil
notification_type "MyString"
read false
resolved false
  end

end
