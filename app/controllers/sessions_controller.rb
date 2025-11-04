# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :already_logged_in, except: [:destroy]

  def new; end

  def create
    case params[:provider]
    when 'developer'
      render :unproccessible_entity and return unless Rails.env.development?

      create_session(:create_developer_user)
    when 'github'
      create_session(:create_github_user)
    when 'google'
      create_session(:create_google_user)
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'You have successfully logged out.'
  end

  def omniauth_failure
    redirect_to root_url,
                alert: "Login failed unexpectedly. (#{params[:message]})"
  end

  private

  def create_session(create_from_provider)
    user_info = request.env['omniauth.auth']
    user = find_or_create_user(user_info, create_from_provider)
    session[:user_id] = user.id
    destination_url = session[:destination_after_login] || root_url
    redirect_to destination_url
  end

  def find_or_create_user(user_info, create_from_provider)
    provider_sym = user_info['provider'].to_sym
    user = User.find_by(
      provider: User.providers[provider_sym],
      uid:      user_info['uid']
    )
    return user unless user.nil?

    send(create_from_provider, user_info)
  end

  def create_developer_user(user_info)
    return unless Rails.env.development?

    User.create(
      uid:        user_info['uid'],
      provider:   :developer,
      first_name: user_info['info']['first_name'],
      last_name:  user_info['info']['last_name'],
      email:      user_info['info']['email']
    )
  end

  def create_google_user(user_info)
    User.create(
      uid:        user_info['uid'],
      provider:   User.providers[:google_oauth2],
      first_name: user_info['info']['first_name'],
      last_name:  user_info['info']['last_name'],
      email:      user_info['info']['email']
    )
  end

  def create_github_user(user_info)
    # Unfortunately, Github doesn't provide first_name, last_name as separate entries.
    name = user_info['info']['name']
    if name.nil?
      first_name = 'GitHub'
      last_name = 'User'
    else
      first_name, last_name = user_info['info']['name'].strip.split(/\s+/, 2)
    end
    User.create(
      uid:        user_info['uid'],
      provider:   User.providers[:github],
      first_name: first_name,
      last_name:  last_name,
      email:      user_info['info']['email']
    )
  end

  def already_logged_in
    redirect_to user_profile_path, notice: 'You are already logged in. Logout to switch accounts.' \
        if current_user.present?
  end
end
