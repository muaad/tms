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
#

class Account < ActiveRecord::Base
end
