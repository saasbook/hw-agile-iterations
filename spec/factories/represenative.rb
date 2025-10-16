# frozen_string_literal: true

# /Users/michael/Dropbox/Projects/cs169/chips/10.5/starter_code/spec/factories/representative.rb

FactoryBot.define do
  factory :representative do
    name { "John Doe" }
    ocdid { "123456" }
    title { "Senator" }
  end
end
