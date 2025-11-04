# frozen_string_literal: true

module ApplicationHelper
  def auth_provider_path(provider)
    path = provider == 'google' ? 'google_oauth2' : provider
    "/auth/#{path}"
  end

  def login_enabled?(provider)
    return true if Rails.env.development?

    client_id = "#{provider.upcase}_CLIENT_ID"
    secret = "#{provider.upcase}_CLIENT_SECRET"
    ENV.fetch(client_id, Rails.application.credentials[client_id.to_sym]).present? &&
      ENV.fetch(secret, Rails.application.credentials[secret.to_sym]).present?
  end

  def self.state_ids_by_name
    State.all.each_with_object({}) do |state, memo|
      memo[state.name] = state.id
    end.to_h
  end

  def self.state_symbols_by_name
    State.all.each_with_object({}) do |state, memo|
      memo[state.name] = state.symbol
    end
  end

  def self.nav_items
    [
      {
        title: 'Home',
        link:  Rails.application.routes.url_helpers.root_path
      },
      {
        title: 'Events',
        link:  Rails.application.routes.url_helpers.events_path
      },
      {
        title: 'Search',
        link:  Rails.application.routes.url_helpers.representatives_path
      }
    ]
  end

  def self.active(curr_controller_name, nav_link)
    nav_controller = Rails.application.routes.recognize_path(nav_link, method: :get)[:controller]
    return 'bg-primary-active' if curr_controller_name == nav_controller

    ''
  end

  def nav_link(title, path, is_current)
    link_to path, class: 'nav-link', 'aria-current': (is_current ? 'page' : nil) do
      parts = [title]
      parts << content_tag(:span, '(current)', class: 'visually-hidden') if is_current
      safe_join(parts, ' ')
    end
  end
end
