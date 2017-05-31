# == Schema Information
#
# Table name: diesel_expenses
#
#  id                :integer          not null, primary key
#  litres            :integer
#  diesel_company_id :integer
#  expense_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  account_id        :integer
#

class DieselExpense < ApplicationRecord
  belongs_to :diesel_company
  belongs_to :expense
end
