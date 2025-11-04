# frozen_string_literal: true

class UserController < ApplicationController
  before_action :require_login!

  def profile
    @user = current_user
  end
end
