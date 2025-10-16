# frozen_string_literal: true

class NewsItem < ApplicationRecord
  belongs_to :representative
  has_many :ratings, dependent: :delete_all

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end
end

#------------------------------------------------------------------------------
# NewsItem
#
# Name              SQL Type             Null    Primary Default
# ----------------- -------------------- ------- ------- ----------
# id                INTEGER              false   true
# title             varchar              false   false
# link              varchar              false   false
# description       TEXT                 true    false
# representative_id INTEGER              false   false
# created_at        datetime             false   false
# updated_at        datetime             false   false
#
#------------------------------------------------------------------------------
