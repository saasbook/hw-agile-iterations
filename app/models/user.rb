# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  provider   :integer          not null
#  uid        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_uid_provider  (uid,provider) UNIQUE
#
class User < ApplicationRecord
  # Add more Authentication Providers here.
  enum :provider, { google_oauth2: 1, github: 2, developer: 3 }, prefix: :provider

  # Each (uid, provider) pair should be unique.
  validates :uid, uniqueness: { scope: :provider }
  has_many :ratings, dependent: :destroy
  def name
    "#{first_name} #{last_name}"
  end

  def auth_provider
    {
      'google_oauth2' => 'Google',
      'github'        => 'GitHub',
      'developer'     => 'Developer'
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
