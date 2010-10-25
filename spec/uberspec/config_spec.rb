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

    it "should set the default notification library to false" do
      @config.notify.should == false
    end

    [:passed, :failed, :pending].each do |status|
      it "should set the default #{status} image" do
        @config.send("#{status}_image").should match(/^.*\/#{status}\.png/i)
      end
    end
  end
end
