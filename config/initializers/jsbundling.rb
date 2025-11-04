# frozen_string_literal: true

Rails.application.config.javascript_path = 'javascript'
Rails.application.config.assets.paths << Rails.root.join('app/assets/builds')
Rails.application.config.assets.precompile += %w[
  application.js
  national_states_map.js
  state_map.js
  county_map.js
  events_new.js
  events_index.js
]
