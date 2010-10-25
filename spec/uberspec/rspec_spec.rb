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

  context "when parsing results" do
    before(:each) do
      @result_string = <<-STRNG

        Finished in 0.12345 seconds

        25 examples, 2 failures, 3 pending

      STRNG

      @parsed_results = @rspec.parse_results(@result_string)
    end

    it "should return the number of examples" do
      @parsed_results[:examples].should == 25
    end

    it "should return the number of failing tests" do
      @parsed_results[:failed].should == 2
    end

    it "should return the number of pending tests" do
      @parsed_results[:pending].should == 3
    end

    it "should return the time it takes to runt he examples" do
      @parsed_results[:time].should == 0.12345
    end
  end
end
