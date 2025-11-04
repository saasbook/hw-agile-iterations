# frozen_string_literal: true

# == Schema Information
#
# Table name: states
#
#  id           :integer          not null, primary key
#  fips_code    :integer          not null
#  is_territory :integer          not null
#  lat_max      :float            not null
#  lat_min      :float            not null
#  long_max     :float            not null
#  long_min     :float            not null
#  name         :string           not null
#  symbol       :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
require 'rails_helper'

RSpec.describe State do
  before do
    bama_attributes = {
      name:         'Alabama',
      symbol:       'AL',
      fips_code:    '01',
      is_territory: 0,
      lat_min:      '-88.473227',
      lat_max:      '-84.88908',
      long_min:     '30.223334',
      long_max:     '-84.88908'
    }
    @sweet_home = described_class.create!(bama_attributes)
    @sweet_home.counties.create!({ name:       'Autauga County',
                                   fips_code:  0o1,
                                   fips_class: 69 })
  end

  it 'fips_code properly left justifies' do
    expect(@sweet_home.std_fips_code).to eq '01'
  end

  it 'deletes all counties when State gets deleted' do
    expect(County.all.length).to eq 1
    described_class.destroy_all
    expect(County.all.length).to eq 0
  end
end
