# frozen_string_literal: true

# This is a collection of small utility steps
# that are not meant to be used frequently.

# rubocop:disable Lint/Debugger
Then /^debug$/ do
  # Use this to write "Then debug" in your scenario to open a console.
  require "byebug"
  byebug
  # binding.irb
  1 # intentionally force debugger context in this method
end

Then /^debug javascript$/ do
  # Use this to write "Then debug javascript" in your scenario to open a JS console
  page.driver.debugger
  1
end

Then /^show me the page$/ do
  save_and_open_page
  save_and_open_screenshot
end
# rubocop:enable Lint/Debugger
