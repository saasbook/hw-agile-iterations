# frozen_string_literal: true

# These debugging steps are provided as utility steps for **while you are
# writing your scenarios**. You should *not* leave them in production tests,
# or code you submit to the autograder, as some steps will cause the
# autograder to stop running (e.g. "Then debug" waits for input that never
# comes).

# These steps exist to call debugging helpers, so Lint/Debugger doesn't apply.
# rubocop:disable Lint/Debugger

module DebuggingHelpers
  # save_and_open_page / save_and_open_screenshot open the saved file with the
  # Launchy gem. Without it, just save the file and print where it went.
  def launchy_available?
    require 'launchy'
    true
  rescue LoadError
    false
  end
end
World(DebuggingHelpers)

Then /^debug$/ do
  # Use this to write "Then debug" in your scenario to open a console.
  #  require "byebug"; byebug
  binding.irb
  1 # intentionally force debugger context in this method
end

Then /^debug javascript$/ do
  # Use this to write "Then debug javascript" in your scenario to open a JS console
  page.driver.debugger
  1
end

Then /^show me the page$/ do
  if launchy_available?
    save_and_open_page
  else
    warn "Saved the page to #{save_page}"
  end

  begin
    if launchy_available?
      save_and_open_screenshot
    else
      # Older Capybara (2.x) requires a path here.
      path = File.expand_path("tmp/capybara/screenshot-#{Time.now.utc.strftime('%Y%m%d%H%M%S%L')}.png")
      FileUtils.mkdir_p(File.dirname(path))
      save_screenshot(path)
      warn "Saved a screenshot to #{path}"
    end
  rescue Capybara::NotSupportedByDriverError
    warn "Tried to take a screenshot but it is not supported by #{Capybara.current_driver}"
  end
end

Then /complete the rest of of this scenario/ do
  # This shows you what a basic cucumber scenario looks like.
  # Replace the line in your scenarios with the appropriate steps.
  raise 'Remove this step from your .feature files'
end

# rubocop:enable Lint/Debugger
