# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'haml-lint analysis' do
  subject(:report) { `bundle exec haml-lint` }

  # Run `bundle exec haml-lint` to see the errors.
  # Run `bundle exec haml-lint -a` to autocorrect them.
  it 'has no offenses' do
    expect(report).to match(/\s\d+ files? inspected, 0 lints detected\s$/)
  end
end
