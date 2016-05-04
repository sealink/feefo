module Feefo
  class RemoteReviewFetcher
    attr_reader :code

    def initialize(filters, config)
      @code     = filters[:code]
      @category = filters[:category]
      @config   = config
    end

    def fetch_reviews
      params = {
        logon:     logon,
        vendorref: @code,
        limit:     @config[:review_limit],
        json:      true,
        mode:      'both'   # Needed to get both product and service rating
      }.reject { |k, v| v.nil? }

      uri          = URI(url)
      uri.query    = URI.encode_www_form(params)
      http         = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.port == 443
      response     = http.get(uri.request_uri)
      response.body
    end


    private

    def logon
      logon = @config[:logon]
      logon += '/' + @config[:division] if @config.key? :division
      logon += '/' + @category if @category
      logon
    end

    def url
      'https://www.feefo.com/feefo/xmlfeed.jsp'
    end
  end
end
