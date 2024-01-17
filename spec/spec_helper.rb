require 'rspec'
require 'webmock/rspec'

# تعطيل الاتصالات الخارجية الحقيقية وتمكين WebMock
WebMock.disable_net_connect!(allow_localhost: true)

# تكوين RSpec
RSpec.configure do |config|
  # إضافة بعض السلوكيات الإعدادية لـ RSpec
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # إعدادات إضافية محتملة لتحسين الاختبارات
  # ...

  # الإعداد الخاص بـ WebMock (إذا كان مطلوبًا)
  config.include WebMock::API
end
