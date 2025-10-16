# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :county

  validates :start_time, :end_time, presence: true
  validates :start_time, date: { after_or_equal_to: proc { Time.zone.now },
                                 message:           'must be after today' }
  validates :end_time, date: { after_or_equal_to: :start_time,
                               message:           'must be after start time' }

  delegate :state, to: :county, allow_nil: true

  def county_names_by_id
    county&.state&.counties.to_h { |c| [c.name, c.id] } || []
  end
end

#------------------------------------------------------------------------------
# Event
#
# Name        SQL Type             Null    Primary Default
# ----------- -------------------- ------- ------- ----------
# id          INTEGER              false   true
# name        varchar              false   false
# description TEXT                 true    false
# county_id   INTEGER              false   false
# start_time  datetime             true    false
# end_time    datetime             true    false
# created_at  datetime             false   false
# updated_at  datetime             false   false
#
#------------------------------------------------------------------------------
