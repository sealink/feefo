require 'spec_helper'
require 'feefo/review_fetcher'
require 'feefo/remote_review_fetcher'

describe "Fetching a set of reviews" do
  let(:cache) { double(read: nil, write: nil) }

  let(:feefo_review_fetcher) do
    config = {
      logon:                 'www.sealinktravelgroup.com.au',
      division:              'SeaLink KI',
      time_to_cache_reviews: 25,
      review_limit:          9
    }
    Feefo::ReviewFetcher.new('HTCC', config, cache)
  end

  subject(:reviews) do
    VCR.use_cassette('feefo_reviews_with_feedback') do
      feefo_review_fetcher.fetch_reviews_json
    end
  end

  it 'should return a String' do
    expect(reviews).to be_an_instance_of(String)
  end

  context 'when converted to json' do
    subject(:json) { JSON.load(reviews) }

    it { should be_a(Hash) }
    it { should include 'FEEDBACKLIST' }

    context 'its FEEDBACK list' do
      let(:feedback) { json['FEEDBACKLIST']['FEEDBACK'] }
      subject(:feedback_length) { feedback.length }

      it { should eq 9 }

      context 'its first FEEDBACK element' do
        subject { feedback.first }
        it { should be_a(Hash) }
        it { should include 'SERVICERATING' }
        # These guys are optional keys:
        # it { should include *%w(SERVICERATING CUSTOMERCOMMENT VENDORCOMMENT) }
      end
    end

    context 'its SUMMARY' do
      subject { json['FEEDBACKLIST']['SUMMARY'] }
      it { should include *%w(COUNT AVERAGE) }
    end
  end
end
