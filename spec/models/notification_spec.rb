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

require 'rails_helper'

RSpec.describe Notification, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
