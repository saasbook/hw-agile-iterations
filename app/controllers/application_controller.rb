# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :current_user

  helper_method :current_user
  def current_user
    return @current_user if defined?(@current_user)

    @current_user = User.find_by(id: session[:user_id])
  end

  def require_login!
    return if current_user.present?

    flash[:notice] = 'Please login before continuing.'
    session[:destination_after_login] = request.env['REQUEST_URI']
    redirect_to login_url
  end
end
