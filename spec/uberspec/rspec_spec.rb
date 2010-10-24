require 'spec/spec_helper.rb'

describe Uberspec::Rspec do
  before(:each) do
    @watchr_script = mock('watchr', :watch => nil)
    @rspec = Uberspec::Rspec.watch(@watchr_script)
  end

  it "should define the command" do
    @rspec.command.should == 'spec'
  end

  it "should define all test files" do
    @rspec.all_test_files.should == Dir['spec/**/*_spec.rb']
  end
end
