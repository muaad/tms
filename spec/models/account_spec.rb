# == Schema Information
#
# Table name: accounts
#
#  id           :integer          not null, primary key
#  name         :string
#  email        :string
#  phone_number :string
#  active       :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  token        :string
#

require 'rails_helper'

RSpec.describe Account, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
