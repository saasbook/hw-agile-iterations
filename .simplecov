# frozen_string_literal: true

# SimpleCov settings shared by RSpec (spec/rails_helper.rb) and Cucumber
# (features/support/env.rb). Each of those calls `SimpleCov.start 'rails'`,
# which builds on what is configured here. SimpleCov loads this file
# automatically; do not call SimpleCov.start from it.
#
# Every test run (rspec, cucumber, cucumber -p a11y) writes its results into
# coverage/ and they are merged into one report: coverage/index.html for
# browsing, coverage/coverage.json for the `simplecov` command line tool.
#
# Useful commands, once you have run the tests:
#   bundle exec simplecov report                          totals, per group
#   bundle exec simplecov uncovered --missing             worst files + lines to test
#   bundle exec simplecov show app/models/state.rb        annotated source
#   bundle exec simplecov tests app/models/state.rb:12    which tests ran line 12
#   bundle exec simplecov patch --base main               coverage of lines you changed
#   bundle exec simplecov open                            open the HTML report
#   bin/coverage-report                                   the summary CI posts on PRs
#
# Full list: bundle exec simplecov help
SimpleCov.configure do
  # rspec, cucumber, and cucumber -p a11y are separate processes. Their results
  # are merged as long as they all finish within this many seconds of each
  # other; the default (10 minutes) is too short for a full local run.
  merge_timeout 3600

  # Record which test exercised each line. The HTML report shows it per line,
  # and `simplecov tests <file>[:<line>]` answers it from the terminal.
  track_tests

  # Optional: also measure the app/views templates, so a page no scenario
  # renders shows up at 0% instead of being silently missing. Views are about
  # half of the app's lines, so turning this on roughly halves the overall
  # percentage; the coverage targets in the instructions assume it is off.
  # cover_views

  ## CS169: You may want to modify some of the testing configuration.
end
