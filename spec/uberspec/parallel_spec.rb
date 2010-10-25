require 'spec/spec_helper.rb'

describe Uberspec::Parallel do
  before(:each) do
    @watchr_script = mock('watchr', :watch => nil)
    @parallel = Uberspec::Parallel.watch(@watchr_script)
  end

  context "with only one match" do
    before(:each) do
      @parallel.stub(:matches).and_return(['one/match'])
    end

    it "should run with only one core" do
      @parallel.command.should == 'parallel_spec -n 1'
    end
  end

  context "with less then five matches" do
    before(:each) do
      @parallel.stub(:matches).and_return(['one/match','two/match','three/match','four/match'])
    end

    it "should run with only two cores" do
      @parallel.command.should == 'parallel_spec -n 2'
    end
  end

  context "with more then five matches" do
    before(:each) do
      @parallel.stub(:matches).and_return(['one/match','two/match','three/match','four/match','five/match','six/match'])
    end

    it "should run with all cores" do
      @parallel.command.should == 'parallel_spec'
    end
  end

  context "when parsing results" do
    before(:each) do
      @result_string = <<-STRNG

Results:
261 examples, 2 failures, 22 pending
258 examples, 0 failures
242 examples, 0 failures, 12 pending
276 examples, 0 failures, 17 pending

Took 29.364053 seconds

      STRNG

      @parsed_results = @parallel.parse_results(@result_string)
    end

    it "should return the number of examples" do
      @parsed_results[:examples].should == 1037
    end

    it "should return the number of failing tests" do
      @parsed_results[:failed].should == 2
    end

    it "should return the number of pending tests" do
      @parsed_results[:pending].should == 51
    end

    it "should return the time it takes to runt he examples" do
      @parsed_results[:time].should == 29.364053
    end
  end
end
