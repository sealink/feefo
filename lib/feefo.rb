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
      logon: config['logon'],
      division: config['division'],
      time_to_cache_reviews: config['time_to_cache_reviews'],
      review_limit: config['review_limit']
    }
  end

  def self.review_base_url
    name     = configEncode(:name)
    logon    = configEncode(:logon)
    division = configEncode(:division)
    "https://www.feefo.com/reviews/#{name}/?logon=#{logon}/#{division}"
  end

  def self.review_badge_image(filters)
    logon          = configEncode(:logon)
    division       = configEncode(:division)
    code           = filters[:code]
    category       = filters[:category]
    base_image_url = "https://www.feefo.com/feefo/feefologo.jsp?logon=#{logon}/#{division}"
    category_part  = category ? category : ''
    code_part      = code     ? code     : ''
    image_template = "&template=product-stars-grey-150x38_en.png"
    return '' unless category || code
    base_image_url + category_part + code_part + image_template
  end

  def self.review_for_code(filters)
    fetcher = ReviewFetcher.new(filters)
    data = JSON.parse(fetcher.fetch_reviews_json)
    Feefo::Reviews.new(data)
  rescue JSON::ParserError => e
    nil
  end

  private

  def configEncode(key)
    URI.encode(config.fetch(key))
  end

end
