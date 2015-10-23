$LOAD_PATH.unshift File.expand_path('../../app/models', __FILE__)

require 'vcr'
require 'support/coverage_loader'

require 'feefo'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end
