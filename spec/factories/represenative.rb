# frozen_string_literal: true

FactoryBot.define do
  factory :representative do
    ocdid { '987654' }
    title { 'Senator' }
  end
end
