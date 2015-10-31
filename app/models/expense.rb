class Expense < ActiveRecord::Base
  belongs_to :expense_category
  belongs_to :product
  belongs_to :driver
  belongs_to :truck
  belongs_to :turn_boy
  belongs_to :user

  def category
  	expense_category
  end
end
