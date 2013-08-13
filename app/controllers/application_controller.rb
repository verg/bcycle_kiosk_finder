class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def find_or_create_user
    @current_user ||= User.where(id: cookies[:current_user_id]).first
    @current_user = User.create if @current_user.blank?
    cookies.permanent[:current_user_id] = @current_user.id
  end
end
