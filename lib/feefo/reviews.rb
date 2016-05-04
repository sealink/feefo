module Feefo
  class Reviews
    attr_reader :reviews, :summary

    def initialize(data)
      list = data.fetch('FEEDBACKLIST')
      @reviews = list.fetch('FEEDBACK', []).map { |review| Feefo::Review.new(review) }
      @summary = list.fetch('SUMMARY')
    end

    def average
      @summary['AVERAGE']
    end

    def count
      @summary['COUNT']
    end
  end
end
