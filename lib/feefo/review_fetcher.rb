module Feefo
  class ReviewFetcher
    attr_reader :code, :feefo_config

    def initialize(code, feefo_config = Feefo.config, cache = Rails.cache)
      @code = code
      @feefo_config = feefo_config
      @cache = cache
    end

    def fetch_reviews_json
      with_caching do
        RemoteReviewFetcher.new(code, feefo_config).fetch_reviews
      end
    end

    private

    def with_caching
      fetch_from_cache || yield.tap { |reviews| store_in_cache(reviews) }
    end

    def fetch_from_cache
      cache.read feefo_key(code)
    end

    def store_in_cache(reviews)
      cache.write feefo_key(code), reviews, expires_in: feefo_config['time_to_cache_reviews']
    end

    def feefo_key(code)
      "feefo_reviews_for_#{code}"
    end

    def cache
      @cache
    end
  end
end
