require 'spec_helper.rb'

describe Uberspec::Notify::Base do
  before(:each) do
    @notifier = Uberspec::Notify::Base.new('path/to/success.png','path/to/failure.png')
  end

  it "should raise error because command is not defined" do
    lambda { @notifier.command }.should raise_error
  end

  context "with failing tests" do
    before(:each) do
      @stats = {:failed => 1, :examples => 100, :pending => 5, :time => 0.1234} 
      @notifier.stub!(:system)
      @notifier.stub!(:command)
      @notifier.notify(@stats)
    end

    it "should set the title to failing" do
      @notifier.title.should == "Tests Failed!"
    end

    it "should add the stats to the body" do
      @notifier.body.split("\n").should include("100 Examples", "5 Pending", "1 Failed")
    end

    it "should say how long the tests took" do
      @notifier.body.split("\n").should include("Tests took 0.1234 seconds")
    end

    it "should use the failure image" do
      @notifier.image.should == 'path/to/failure.png'
    end
  end

  context "with no failing tests" do
    before(:each) do
      @stats = {:failed => 0, :examples => 100, :pending => 5, :time => 0.1234} 
      @notifier.stub!(:system)
      @notifier.stub!(:command)
      @notifier.notify(@stats)
    end

    it "should set the title to failing" do
      @notifier.title.should == "Tests Passed!"
    end

    it "should add the stats to the body" do
      @notifier.body.split("\n").should include("100 Examples", "5 Pending", "0 Failed")
    end

    it "should user the success image" do
      @notifier.image.should == 'path/to/success.png'
    end
  end

end
