# frozen_string_literal: true

# == Schema Information
#
# Table name: news_items
#
#  id                :integer          not null, primary key
#  description       :text
#  issue             :string
#  link              :string           not null
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  representative_id :integer          not null
#
# Indexes
#
#  index_news_items_on_representative_id  (representative_id)
#
class NewsItem < ApplicationRecord
  # TODO: this belongs to a user (creator_id)
  belongs_to :representative

  def self.find_for(representative_id)
    NewsItem.find_by(
      representative_id: representative_id
    )
  end
end
