# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'eslint analysis' do
  subject(:report) { `npm run lint` } # `lint` in `package.json` $.scripts.lint

  # Run `npm run lint` to see the errors.
  # Run `npm run lint:fix` to fix eslint errors.
  it 'has no offenses' do
    report
    expect(report).not_to match(/\d+ errors/)
    # rubocop:disable Style/SpecialGlobalVars
    expect($?.exitstatus).to eq(0), 'Eslint exits with response code 1 when there are lint errors'
    # rubocop:enable Style/SpecialGlobalVars
    expect(report).to match(/> actionmap@0.0.1 lint$/)
  end
end
