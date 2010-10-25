require 'spec_helper'

describe Uberspec::Notify::Growl do
  before(:each) do
    @notifier = Uberspec::Notify::Growl.new('path/to/success.png','path/to/failure.png')
    @stats = {:failed => 1, :examples => 100, :pending => 5, :time => 0.1234} 
  end

  it "should have command defined" do
    @notifier.stub!(:system)
    @notifier.notify(@stats)
    @notifier.command.should == 'growlnotify'
  end

  it "should send the correct command" do
    @notifier.should_receive(:system).with(/growlnotify/)# '.*' '.*' -i '.*'/i) 
    @notifier.notify(@stats)
  end


end
