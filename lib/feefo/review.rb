module Feefo
  class Review
    def initialize(review)
      @review = review
    end

    def customer_comment
      @review['CUSTOMERCOMMENT']
    end

    def review_date
      @review['HREVIEWDATE']
    end

    def service_rating
      @review['SERVICERATING']
    end

    def product_rating
      @review['PRODUCTRATING']
    end

    def vendor_comment
      @review['VENDORCOMMENT']
    end

    def review_rating
      @review['HREVIEWRATING']
    end

    def description
      @review['DESCRIPTION']
    end
  end
end
