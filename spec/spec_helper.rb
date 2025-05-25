require 'bundler/setup'
Bundler.setup

require_relative '../lib/symbolic_differentiator'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
