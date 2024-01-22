require 'rspec'
require 'webmock/rspec'

# Disable real external connections and enable WebMock
WebMock.disable_net_connect!(allow_localhost: true)

# Configure RSpec
RSpec.configure do |config|
  # Add some setup behaviors for RSpec
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Possible additional settings to improve tests


  # WebMock-specific setup (if required)
  config.include WebMock::API
end
