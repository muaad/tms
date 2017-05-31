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

class Driver < ApplicationRecord
	attr_accessor :salary
	has_many :truck_drivers
	has_many :trucks, through: :truck_drivers
	has_many :expenses
	has_many :attachments
	belongs_to :account
	acts_as_tenant(:account)

	def truck
		t = nil
		t = truck_drivers.where(active: true).first.truck if !truck_drivers.where(active: true).first.nil?
	end

	def calculate_salary truck
		sal = nil
		t = truck_drivers.where(truck: truck).first
		sal = t.salary if !t.nil?
	end
end
