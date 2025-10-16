# frozen_string_literal: true

#------------------------------------------------------------------------------
# Representative
#
# Name       SQL Type             Null    Primary Default
# ---------- -------------------- ------- ------- ----------
# id         INTEGER              false   true
# name       varchar              true    false
# created_at datetime             false   false
# updated_at datetime             false   false
# ocdid      varchar              true    false
# title      varchar              true    false
#
#------------------------------------------------------------------------------

class Representative < ApplicationRecord
  has_many :news_items, dependent: :delete_all

  def self.civic_api_to_representative_params(rep_info)
    reps = []

    rep_info.officials.each_with_index do |official, index|
      ocdid_temp = ''
      title_temp = ''

      rep_info.offices.each do |office|
        if office.official_indices.include?(index)
          title_temp = office.name
          ocdid_temp = office.division_id
        end
      end

      rep = Representative.create!({ name: official.name, ocdid: ocdid_temp,
          title: title_temp })
      reps.push(rep)
    end

    reps
  end
end
