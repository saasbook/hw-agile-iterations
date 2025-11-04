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
class State < ApplicationRecord
  has_many :counties, inverse_of: :state, dependent: :delete_all

  # Standardized FIPS code eg. 06 for 6.
  def std_fips_code
    fips_code.to_s.rjust(2, '0')
  end
end
