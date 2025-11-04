# frozen_string_literal: true

require 'spec_helper'
# require 'congress_api'

RSpec.describe Congress::Client do
  it 'errors without an api key' do
    expect { described_class.new(nil) }.to raise_error(ArgumentError)
  end

  it 'can be initialized' do
    expect(described_class.new('test')).not_to be_nil
  end
end
