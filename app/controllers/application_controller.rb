class ApplicationController < ActionController::Base
   before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
   protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }

   protected
   def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :password, :password_confirmation) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :password_confirmation) }
   end
end
