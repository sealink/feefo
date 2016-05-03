module Feefo
  class Review
    attr_reader :data

    def initialize(data)
      @data = data
    end

    def customer_comment
      data['CUSTOMERCOMMENT']
    end

    def review_date
      data['HREVIEWDATE']
    end

    def service_rating
      data['SERVICERATING']
    end

    def vendor_comment
      data['VENDORCOMMENT']
    end

    def review_rating
      data['HREVIEWRATING']
    end

    def description
      data['DESCRIPTION']
    end

    def link
      data['LINK']
    end

    def date
      data['DATE']
    end
  end
end
