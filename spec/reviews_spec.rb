require 'spec_helper'

describe Feefo::Reviews do
  let(:cache) { double(read: nil, write: nil) }
  let(:feefo_review_fetcher) do
    config = {
      account:               'www.sealinktravelgroup.com.au/SeaLink KI',
      time_to_cache_reviews: 25,
      review_limit:          9
    }
    Feefo::ReviewFetcher.new('HTCC', config, cache)
  end
  let(:data) do
    VCR.use_cassette('feefo_reviews_with_feedback') do
      JSON.parse(feefo_review_fetcher.fetch_reviews_json)
    end
  end
  subject(:reviews) { Feefo::Reviews.new(data) }

  it 'should parse reviews' do
    expect(reviews.average).to eq 97
    expect(reviews.count).to eq 284
  end

  context 'reviews' do
    subject(:review) { reviews.reviews.first }
    it 'should have the various aspects' do
      expect(review.customer_comment).to be_a(String)
      expect(review.vendor_comment).to be nil
      expect(review.description).to eq 'KI Experience'
      expect(review.service_rating).to eq '+'
      expect(review.product_rating).to eq '+'
      expect(review.review_date).to eq '2015-10-21T05:27:07'
      expect(review.review_rating).to eq 4
    end
  end
end
