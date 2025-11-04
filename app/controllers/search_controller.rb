# frozen_string_literal: true

class SearchController < ApplicationController
  def search
    Rails.logger.debug params[:address]
    @search_term = CGI.unescape(params[:address].to_s)
    data = Representative.geocodio_search(params[:address])
    @representatives = Representative.civic_api_to_representative_params(data)
    render 'representatives/search'
  end
end
