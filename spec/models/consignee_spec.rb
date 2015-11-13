# == Schema Information
#
# Table name: consignees
#
#  id           :integer          not null, primary key
#  name         :string
#  phone_number :string
#  city_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Consignee, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
