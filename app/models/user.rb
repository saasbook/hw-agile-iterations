# frozen_string_literal: true

class User < ApplicationRecord
  # Add more Authentication Providers here.
  enum provider: { google_oauth2: 1, github: 2 }, _prefix: :provider

  # Each (uid, provider) pair should be unique.
  validates :uid, uniqueness: { scope: :provider }

  def name
    "#{first_name} #{last_name}"
  end

  def auth_provider
    {
      'google_oauth2' => 'Google',
      'github'        => 'Github'
    }[provider]
  end

  def self.find_google_user(uid)
    User.find_by(
      provider: User.providers[:google_oauth2],
      uid:      uid
    )
  end

  def self.find_github_user(uid)
    User.find_by(
      provider: User.providers[:github],
      uid:      uid
    )
  end
end

#------------------------------------------------------------------------------
# User
#
# Name       SQL Type             Null    Primary Default
# ---------- -------------------- ------- ------- ----------
# id         INTEGER              false   true
# provider   INTEGER              false   false
# uid        varchar              false   false
# email      varchar              true    false
# first_name varchar              true    false
# last_name  varchar              true    false
# created_at datetime             false   false
# updated_at datetime             false   false
#
#------------------------------------------------------------------------------
