class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ActionView::Helpers::NumberHelper

  protect_from_forgery with: :exception
  layout :layout_by_resource
  helper_method :resource, :devise_mapping, :resource_name, :to_currency, :trip_expenses_table

  set_current_tenant_through_filter
  before_filter :filter_tenant_via_devise_or_params

  def filter_tenant_via_devise_or_params
    if user_signed_in?
      account = current_user.account
      set_current_tenant(account)
    end
  end

  def trip_expenses_table truck, from, to
    trips = truck.trips.date_between(from, to)
    records = []
    trip_xp ={}
    ind = 1
    grand_net_total = 0.0
    grand_short_total = 0.0
    grand_shilling_total = 0.0
    grand_dollar_total = 0.0
    grand_commission_total = 0.0
    grand_amount_total = 0.0
    trips.each do |trip|
      total_expense = 0.0
      total_dollar = 0.0
      total_shilling = 0.0

      trip_xp[ind] = []
      trip_xp[ind] << {
        number: 1,
        date: trip.date,
        depot: trip.depot.name,
        destination: trip.destination.name,
        consignee: trip.consignee.name,
        product: trip.product.name,
        quantity: trip.quantity,
        rate: trip.rate,
        amount: trip.amount,
        commission: trip.commission,
        short: trip.short,
        description: trip.description,
        account: "",
        amount_sh: 0.00,
        ex_rate: 0.00,
        amount_dol: 0.00,
        net_pay: to_currency(trip.amount)
      }

      trip_expenses(trip).each do |expense|
        trip_xp[ind] << expense
        total_expense += expense[:net_pay].gsub('(', '').gsub('$', '').gsub(')', '').to_f
        total_dollar += expense[:amount_dol].to_f
        total_shilling += expense[:amount_sh].to_f
      end

      total_net = to_currency(trip.amount - total_expense, unit: "")
      total_short = trip.short.to_f
      total_commission = trip.commission.to_f
      total_amount = trip.amount.to_f

      grand_net_total += total_net.to_f
      grand_short_total += total_short
      grand_shilling_total += total_shilling
      grand_dollar_total += total_dollar
      grand_commission_total += total_commission
      grand_amount_total += total_amount

      trip_xp[ind] << {total_net: total_net, total_dollar: to_currency(total_dollar, unit: ""), total_shilling: to_currency(total_shilling, unit: ""), total_short: to_currency(total_short, unit: ""), total_commission: to_currency(total_commission, unit: ""), total_amount: to_currency(total_amount, unit: "")}
      records << trip_xp[ind]
      ind += 1
    end
    records << {
      grand_net_total: grand_net_total,
      grand_short_total: grand_short_total,
      grand_shilling_total: grand_shilling_total,
      grand_dollar_total: grand_dollar_total,
      grand_commission_total: grand_commission_total,
      grand_amount_total: grand_amount_total
    }
    records
  end

  def trip_expenses trip
    expenses = []
    n = 2
    trip.expenses.each do |expense|
      expenses << {
        number: n,
        date: expense.date,
        depot: "",
        destination: "",
        consignee: "",
        product: (expense.product.nil? ? "" : expense.product.name),
        quantity: (expense.quantity.blank? ? 0.00 : expense.quantity),
        rate: 0.00,
        amount: 0.00,
        commission: 0.00,
        short: 0.00,
        description: expense.description,
        account: expense.category.nil? ? "" : expense.category.name,
        amount_sh: to_currency(expense.amount, unit: ""),
        ex_rate: ExchangeRate.first.rate,
        amount_dol: to_currency(expense.dollar_amount.blank? ? (expense.amount / ExchangeRate.first.rate) : expense.dollar_amount, unit: ""),
        net_pay: "(#{to_currency(expense.dollar_amount.blank? ? (expense.amount / ExchangeRate.first.rate) : expense.dollar_amount, unit: '')})"
      }
      n += 1
    end
    expenses
  end

  def to_currency number, options={}
    if !number.blank?
      number_to_currency(number, options)
    else
      0.0
    end
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
   @devise_mapping ||= Devise.mappings[:user]
  end

  def self.random_string
    cs = [*'0'..'9', *'a'..'z']
    5.times.map { cs.sample }.join.downcase
  end

    protected

    def layout_by_resource
      if devise_controller?
        "public"
      end
    end
end
