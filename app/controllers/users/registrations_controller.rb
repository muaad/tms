class Users::RegistrationsController < Devise::RegistrationsController
	before_filter :configure_permitted_parameters, if: :devise_controller?

	def create
		super
		if resource.valid?
			user = User.find(resource.id)
			user.is_admin = true
			user.save!
		end
		sign_in resource
	end

	def edit
		render layout: 'application'
	end

	protected

		def after_sign_up_path_for(resource)
    		new_account_path
	  	end

	    def configure_permitted_parameters
	      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :is_admin, :email, :password) }
	    end

	    def after_update_path_for(resource)
	      dashboard_path
	    end
end
