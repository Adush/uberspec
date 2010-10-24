require 'spec/spec_helper.rb'

describe Uberspec::Config do
  context "when initialized" do
    before(:each) do
      @config = Uberspec::Config.new
    end

    it "should add default code path when initialized" do
      @config.code_paths.length.should == 1
    end
    
    it "should add default spec path when initialized" do
      @config.spec_paths.length.should == 1
    end

    it "should set the defaul notification library to false" do
      @config.notify.should == false
    end
  end
end
