require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |config|

  config.module_path = File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'modules')
  config.manifest_dir = File.join(File.dirname(File.expand_path(__FILE__)), 'fixtures', 'manifests')
  config.environmentpath = spec_path = File.expand_path(File.join(Dir.pwd, 'spec'))

  config.before :each do
    # Ensure that we don't accidentally cache facts and environment between
    # test cases.  This requires each example group to explicitly load the
    # facts being exercised with something like
    # Facter.collection.loader.load(:ipaddress)
    Facter.clear
    Facter.clear_messages

    RSpec::Mocks.setup
  end

  config.after :each do
    RSpec::Mocks.verify
    RSpec::Mocks.teardown
  end

end
