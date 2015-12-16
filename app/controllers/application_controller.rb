class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include ActionView::Helpers::NumberHelper

  protect_from_forgery with: :exception
  layout :layout_by_resource
  helper_method :resource, :devise_mapping, :resource_name, :to_currency

  set_current_tenant_through_filter
  before_filter :filter_tenant_via_devise_or_params

  def filter_tenant_via_devise_or_params 
    if user_signed_in?
      account = current_user.account
      set_current_tenant(account)
    # elsif params[:account].present?
    #   account = Account.find_by_phone_number(params[:account])
    #   set_current_tenant(account)
    # elsif params[:token].present?
    #   # possibly an API client
    #   account = Account.find_by_auth_token(params[:token])
    #   set_current_tenant(account)
    # else
    #   # token authentication via API
    #   authenticate_with_http_token do |token|        
    #     account = Account.find_by_auth_token(token)
    #     set_current_tenant(account)
    #   end
    end
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
