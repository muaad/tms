# == Schema Information
#
# Table name: products
#
#  id           :integer          not null, primary key
#  name         :string
#  price        :float
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  product_type :string
#  account_id   :integer
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
