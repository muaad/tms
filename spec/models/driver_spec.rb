# == Schema Information
#
# Table name: drivers
#
#  id           :integer          not null, primary key
#  name         :string
#  phone_number :string
#  address      :string
#  id_number    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_id   :integer
#

require 'rails_helper'

RSpec.describe Driver, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
