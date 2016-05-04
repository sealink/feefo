require 'spec_helper'
require 'feefo'

describe 'Feefo' do
  before do
    Feefo.config = {
      'logon'    => 'www.link.com',
      'division' => 'My Brand'
    }
    @code = 'abc'
    @category = 'cat'
  end

  it 'should determine url' do
    expected_url = 'https://www.feefo.com/feefo/feefologo.jsp?logon=www.link.com/My%20Brand/cat&vendorref=abc&template=product-stars-grey-150x38_en.png'
    expect(Feefo.review_badge_image(code: @code, category: @category)).to eq expected_url
  end
end
