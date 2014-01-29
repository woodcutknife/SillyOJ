class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :store_location

  protected

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/auth\/hackers/
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end

  def authenticate_admin_user!
    authenticate_hacker!
    unless current_hacker.admin?
      flash[:alert] = "This area is restricted to administrators only."
      redirect_to root_path
    end
  end

  def current_admin_user
    return nil if hacker_signed_in? && !current_hacker.admin?
    current_hacker
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  def check_contest_started!
    if not @contest.started
      flash[:alert] = "This contest does not start."
      redirect_to contests_path
    end
  end

  def check_contest_registered!
    if not current_hacker.contests.member?(@contest)
      flash[:alert] = "You do not joined this contest."
      redirect_to contests_path
    end
  end
end
