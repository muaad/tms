class Cash < ActiveRecord::Base
	include Reportable
	attr_accessor :total_cash

	belongs_to :account
	acts_as_tenant(:account)

	def self.total
		sum(:amount_in)
	end
end
