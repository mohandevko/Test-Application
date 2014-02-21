class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, :if => :devise_controller?
  helper :all
  
  def is_login
    unless current_user
      flash[:error] = "Please login!"
      redirect_to root_path
    end
  end
  
  def is_admin
    unless current_user and current_user.role == 'admin'
      flash[:error] = "Access denied!"
      redirect_to root_path
    end
  end
    
  protected
    
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { 
      |u| u.permit([:username,:first_name,:last_name,:email,:password,:password_confirmation]) 
    }
  end
end
