# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'rubocop analysis' do
  subject(:report) { `bundle exec rubocop --config .rubocop.yml` }

  rubocop_message = <<~TXT
    There are code style (linter) errors in your Ruby code.
    Run `bundle exec rubocop -a` to auto-correct some linter errors.
    Check out the docs: https://docs.rubocop.org/rubocop/1.42/cops.html
  TXT
  it 'has no offenses' do
    expect(report).to match(/no offenses detected$/), rubocop_message
  end
end
