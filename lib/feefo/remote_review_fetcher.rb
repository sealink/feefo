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
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.port == 443
      response = http.get(uri.request_uri)
      response.body
    end


    private

    def logon
      @config[:logon] + '/' + @config[:division]
    end

    def url
      'https://www.feefo.com/feefo/xmlfeed.jsp'
    end
  end
end
