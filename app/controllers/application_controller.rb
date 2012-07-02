class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :current_user
  def current_user
    @current_user ||= User.first
  end
  
  helper_method :current_user
end
