# frozen_string_literal: true

class County < ApplicationRecord
  belongs_to :state

  # Standardized FIPS code eg. 001 for 1.
  def std_fips_code
    fips_code.to_s.rjust(3, '0')
  end
end

#------------------------------------------------------------------------------
# County
#
# Name       SQL Type             Null    Primary Default
# ---------- -------------------- ------- ------- ----------
# id         INTEGER              false   true
# name       varchar              false   false
# state_id   INTEGER              false   false
# fips_code  integer(2)           false   false
# fips_class varchar(2)           false   false
# created_at datetime             false   false
# updated_at datetime             false   false
#
#------------------------------------------------------------------------------
