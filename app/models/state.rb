# frozen_string_literal: true

class State < ApplicationRecord
  has_many :counties, inverse_of: :state, dependent: :delete_all

  # Standardized FIPS code eg. 06 for 6.
  def std_fips_code
    fips_code.to_s.rjust(2, '0')
  end
end

#------------------------------------------------------------------------------
# State
#
# Name         SQL Type             Null    Primary Default
# ------------ -------------------- ------- ------- ----------
# id           INTEGER              false   true
# name         varchar              false   false
# symbol       varchar              false   false
# fips_code    integer(1)           false   false
# is_territory INTEGER              false   false
# lat_min      float                false   false
# lat_max      float                false   false
# long_min     float                false   false
# long_max     float                false   false
# created_at   datetime             false   false
# updated_at   datetime             false   false
#
#------------------------------------------------------------------------------
