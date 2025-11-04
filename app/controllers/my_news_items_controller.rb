# frozen_string_literal: true

class MyNewsItemsController < ApplicationController
  before_action :require_login!

  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
  end

  def edit
    # Make sure to save the news item creator
  end

  def create
    @news_item = NewsItem.new(news_item_params)
    # Make sure to save the news item creator
    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    update_values = news_item_params
    # BEIGN SOLUTION CS169
    args = news_item_update_params
    rating = Rating.find_or_create_by(user: current_user, news_item: @news_item)
    rating.update(value: args['rating'])
    rating.save

    total_ratings = @news_item.ratings.pluck(:value).inject(:+)
    update_values[:rating] = total_ratings / @news_item.ratings.size

    if @news_item.update(update_values)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :issue, :description, :link, :representative_id, :rating)
  end

  def news_item_update_params
    params.require(:news_item).permit(:rating)
  end
end
