# frozen_string_literal: true

# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  description :text
#  end_time    :datetime
#  name        :string           not null
#  start_time  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  county_id   :integer          not null
#
# Indexes
#
#  index_events_on_county_id  (county_id)
#
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
