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

class Cash < ApplicationRecord
	include Reportable
	attr_accessor :total_cash

	belongs_to :account
	acts_as_tenant(:account)

	def self.total
		sum(:amount_in)
	end
end
