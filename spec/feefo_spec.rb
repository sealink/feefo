require 'spec_helper'
require 'feefo'

describe 'Feefo' do
  before do
    Feefo.config = {
      'account' => 'www.link.com/My Brand',
      'name'    => 'My Company'
    }
  end

  it 'should determine url' do
    expected_url = 'http://www.feefo.com/reviews/My%20Company/?logon=www.link.com/My%20Brand'
    expect(Feefo.review_base_url).to eq expected_url
  end
end
