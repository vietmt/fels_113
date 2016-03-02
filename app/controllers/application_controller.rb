class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do
      |u| u.permit(:name, :avatar, :email,
      :password, :password_confirmation)}
    end
    devise_parameter_sanitizer.for(:account_update) do
      |u| u.permit(:name, :avatar, :email,
      :password, :password_confirmation, :current_password)
    end
  end
end
