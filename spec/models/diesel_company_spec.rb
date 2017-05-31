# == Schema Information
#
# Table name: diesel_companies
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :integer
#

require 'rails_helper'

RSpec.describe DieselCompany, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
