require 'feefo/remote_review_fetcher'
require 'feefo/review_fetcher'
require 'feefo/review'
require 'feefo/reviews'
require 'feefo/version'

module Feefo
  def self.config
    @config
  end

  def self.config=(config)
    @config = {
      name: config['name'],
      account: config['account'],
      time_to_cache_reviews: config['time_to_cache_reviews'],
      review_limit: config['review_limit']
    }
  end

  def self.review_base_url
    name    = URI.encode(config.fetch(:name))
    account = URI.encode(config.fetch(:account))
    "http://www.feefo.com/reviews/#{name}/?logon=#{account}"
  end

  def self.review_for_code(code)
    fetcher = ReviewFetcher.new(code)
    data = JSON.parse(fetcher.fetch_reviews_json)
    Feefo::Reviews.new(data)
  rescue JSON::ParserError => e
    nil
  end
end
