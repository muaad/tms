class DieselExpense < ActiveRecord::Base
  belongs_to :diesel_company
  belongs_to :expense
end
