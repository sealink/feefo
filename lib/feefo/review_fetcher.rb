module Feefo
  class ReviewFetcher
    attr_reader :filters, :feefo_config

    def initialize(filters, feefo_config = Feefo.config, cache = Rails.cache)
      @filters      = filters
      @feefo_config = feefo_config
      @cache        = cache
    end

    def fetch_reviews_json
      with_caching do
        RemoteReviewFetcher.new(filters, feefo_config).fetch_reviews
      end
    end

    private

    def with_caching
      fetch_from_cache || yield.tap { |reviews| store_in_cache(reviews) }
    end

    def fetch_from_cache
      cache.read feefo_key(filters)
    end

    def store_in_cache(reviews)
      cache.write feefo_key(filters), reviews, expires_in: feefo_config[:time_to_cache_reviews]
    end

    def feefo_key(filters)
      "feefo_reviews_for_#{filters[:code]}_#{filters[:category]}"
    end

    def cache
      @cache
    end
  end
end
