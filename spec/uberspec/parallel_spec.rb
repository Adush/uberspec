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
end
