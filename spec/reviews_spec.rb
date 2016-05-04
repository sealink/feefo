require 'spec_helper'

describe Feefo::Reviews do
  let(:cache) { double(read: nil, write: nil) }
  let(:feefo_review_fetcher) do
    config = {
      logon:                 'www.sealinktravelgroup.com.au',
      division:              'SeaLink KI',
      time_to_cache_reviews: 25,
      review_limit:          9
    }
    Feefo::ReviewFetcher.new({code: 'HTCC'}, config, cache)
  end
  let(:data) do
    VCR.use_cassette('feefo_reviews_with_feedback') do
      JSON.parse(feefo_review_fetcher.fetch_reviews_json)
    end
  end
  subject(:reviews) { Feefo::Reviews.new(data) }

  it 'should parse reviews' do
    expect(reviews.average).to eq 97
    expect(reviews.count).to eq 352
  end
  let(:hours_ago_regex) { /[0-9]{1,2} Hour\(s\) ago/ }
  let(:time_regex) { /[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}/ }
  let(:date_regex) { /[0-9]{1,2}-[A-Z][a-z][a-z]-[0-9]{4}/ }

  context 'latest reviews' do
    subject(:review) { reviews.reviews.first }
    it 'should have the various aspects' do
      expect(review.customer_comment).to be_a(String)
      expect(review.vendor_comment).to be nil
      expect(review.description).to eq 'KI Experience'
      expect(review.service_rating).to eq '++'
      expect(review.review_date).to match time_regex
      expect(review.review_rating).to eq 5
      expect(review.link).to eq 'http://www.sealink.com.au/kangaroo-island-tours/1-day-tours/kangaroo-island-highlights-day-tour/'
      expect(review.date).to match hours_ago_regex
      expect(review.data).to be_a(Hash)
    end
  end

  context 'oldest reviews' do
    subject(:review) { reviews.reviews.last }
    it 'should have the various aspects' do
      expect(review.customer_comment).to be_a(String)
      expect(review.vendor_comment).to be nil
      expect(review.description).to eq 'KI Experience'
      expect(review.service_rating).to eq '++'
      expect(review.review_date).to match time_regex
      expect(review.review_rating).to eq 5
      expect(review.link).to eq 'http://www.sealink.com.au/kangaroo-island-tours/1-day-tours/kangaroo-island-highlights-day-tour/'
      expect(review.date).to match date_regex
      expect(review.data).to be_a(Hash)
    end
  end
end
