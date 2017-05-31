# == Schema Information
#
# Table name: cashes
#
#  id          :integer          not null, primary key
#  date        :date
#  amount_in   :float
#  amount_out  :float
#  balance     :float
#  closed      :boolean          default(FALSE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lpo         :string
#  description :text
#  account_id  :integer
#

require 'rails_helper'

RSpec.describe Cash, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
