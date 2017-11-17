require 'pry'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.disable_monkey_patching!
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed

  config.expose_dsl_globally = true

  config.warnings = false
end

require 'honitor'

TEST_CONFIG = UserConfig.new(
  name: 'Test Config',
  link: "file://#{File.dirname(__FILE__)}/support/test.html",
  dom_class: '.super',
  interval: 0,
  random: true,
  log: true
)