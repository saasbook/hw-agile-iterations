require 'faraday'
require 'json'

module Congress
  module Pagination
    def get_all
      PaginatedResults.new(self)
    end
  end

  class PaginatedResults
    include Enumerable

    def initialize(response)
      @response = response
    end

    def each(&block)
      return enum_for(:each) unless block_given?

      offset = 0
      loop do
        results = @response.pagination_request(offset)
        break if results.empty?

        results.each(&block)
        offset += results.size

        break if results.size < 20  # Default page size
      end
    end
  end

  class Response
    attr_reader :client, :path, :params

    def initialize(client, path, params = {})
      @client = client
      @path = path
      @params = params
    end

    def get
      client.get(path, params)
    end

    def pagination_request(offset)
      updated_params = params.merge(offset: offset)
      response = client.get(path, updated_params)
      extract_items(response)
    end

    private

    def extract_items(response)
      # Handle different response structures
      items = if response.dig('bills')
        response['bills']
      elsif response.dig('members')
        response['members']
      elsif response.dig('committees')
        response['committees']
      else
        Array(response)
      end

      items
    end

    include Pagination
  end

  class Client
    BASE_URL = 'https://api.congress.gov/v3'

    def initialize(api_key)
      raise Error, "API key is missing" if api_key.nil? || api_key.strip.empty?
      @api_key = api_key
      @conn = Faraday.new(url: BASE_URL) do |f|
        f.request :json
        f.response :json
        f.adapter Faraday.default_adapter
      end
    end

    def bills(congress:, type: 'all', offset: 0, limit: 20)
      Response.new(self, "bill/#{congress}/#{type}", offset: offset, limit: limit)
    end

    def bill_detail(congress:, bill_type:, bill_number:)
      Response.new(self, "bill/#{congress}/#{bill_type}/#{bill_number}").get
    end

    def amendments(congress:, bill_type:, bill_number:)
      Response.new(self, "bill/#{congress}/#{bill_type}/#{bill_number}/amendments")
    end

    def cosponsors(congress:, bill_type:, bill_number:)
      Response.new(self, "bill/#{congress}/#{bill_type}/#{bill_number}/cosponsors")
    end

    def members(congress:, chamber:)
      Response.new(self, "member/#{congress}/#{chamber}")
    end

    def member_detail(bioguide_id:)
      Response.new(self, "member/#{bioguide_id}").get
    end

    def search_bills(query:, congress: nil, offset: 0, limit: 20)
      params = {
        query: query,
        offset: offset,
        limit: limit
      }
      params[:congress] = congress if congress
      Response.new(self, "bill", params)
    end

    def committees(congress:, chamber:)
      Response.new(self, "committee/#{congress}/#{chamber}")
    end

    def get(path, params = {})
      params = params.merge(api_key: @api_key)
      response = @conn.get(BASE_URL + path) do |req|
        req.params = params
        req.headers['Accept'] = 'application/json'
      end

      handle_response(response)
    end

    private

    def handle_response(response)
      case response.status
      when 200
        response.body
      when 401
        raise Error, "Unauthorized: Invalid API key"
      when 404
        raise Error, "Not found: The requested resource does not exist"
      when 429
        raise Error, "Rate limit exceeded"
      else
        raise Error, "API error: #{response.status} - #{response.body}"
      end
    end
  end

  class Error < StandardError; end
end
