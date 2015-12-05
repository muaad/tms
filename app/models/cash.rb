class Cash < ActiveRecord::Base
	include Reportable
	attr_accessor :total_cash

	def self.total
		sum(:amount_in)
	end
end
