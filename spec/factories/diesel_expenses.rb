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

FactoryGirl.define do
  factory :diesel_expense do
    litres 1
diesel_company nil
expense nil
  end

end
