module Feefo
  class RemoteReviewFetcher
    attr_reader :code

    def initialize(code, config)
      @code   = code
      @config = config
    end

    def fetch_reviews
      params = {
        logon:     logon,
        vendorref: @code,
        limit:     @config[:review_limit],
        json:      true,
        mode:      'both'   # Needed to get both product and service rating
      }

      uri       = URI(url)
      uri.query = URI.encode_www_form(params)

      Net::HTTP.get(uri)
    end


    private

    def logon
      @config[:logon] + '/' + @config[:division]
    end

    def url
      'http://www.feefo.com/feefo/xmlfeed.jsp'
    end
  end
end
