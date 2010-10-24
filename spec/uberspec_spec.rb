require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Uberspec::Base do
  before(:each) do
    @watchr_script = mock('watchr', :watch => nil)
  end

  context "when calling watch" do
    it "should create a new Uberspec::Rspec object" do
      Uberspec::Base.watch(@watchr_script).class.should == Uberspec::Base
    end

    context "without a block of options" do
      before(:each) do
        @base = Uberspec::Base.watch(@watchr_script)
      end
      
      it "should set the configuration object" do
        @base.config.class.should == Uberspec::Config
      end

      it "should use the default config object if no options are given." do
        @base.config.notify.should == Uberspec::Config.new.notify
        @base.config.code_paths.should == Uberspec::Config.new.code_paths
        @base.config.spec_paths.should == Uberspec::Config.new.spec_paths
      end

      it "should store the watchr script" do
        @base.watchr.should == @watchr_script
      end
    end

    context "with a option block" do
      before(:each) do
        @base = Uberspec::Base.watch(@watchr_script) do |config|
          config.code_paths += ['code/path']
          config.spec_paths = ['spec/path']
        end
      end

      it "should add the code paths" do
        @base.config.code_paths.should include('code/path')
      end

      it "should overwrite the spec paths" do
        @base.config.spec_paths.should == ['spec/path']
      end
    end

    it "should start watching files" do
      @watchr_script.should_receive(:watch).twice
      @base = Uberspec::Base.watch(@watchr_script)
    end
  end

  context "running files" do
    before(:each) do
      @base = Uberspec::Base.watch(@watchr_script)
    end

    it "should expect command to be defined" do
      lambda { @base.command }.should raise_error
    end

    it "should expect all test files to be defined" do
      lambda { @base.all_test_files}.should raise_error
    end

    it "should run all files" do
      @base.should_receive(:all_test_files)
      @base.should_receive(:run)
      @base.run_all
    end

    it "should run all from the class level" do
      pending "Not sure this is the best implimentation, nor how to test it"
      @base.stub!(:all_test_files).and_return(['code/paths'])
      @base.should_receive(:run_all)
      Uberspec::Base.run_all
    end

    context "when no match is found" do
      before(:each) do
        @base.stub!(:all_test_files).and_return([])
      end

      it "should not run" do
        @base.should_not_receive(:run)
        @base.find_and_run_match('spec_name')
      end

      it "should set matches to empty" do
        @base.find_and_run_match('spec_name')
        @base.matches.should == []
      end
    end

    context "when one match is found" do
      before(:each) do
        @base.stub!(:all_test_files).and_return(['spec/path'])
      end

      it "should set the matches" do
        @base.stub!(:run)
        @base.find_and_run_match('path')
        @base.matches.should == ['spec/path']
      end

      it "should run" do
        @base.should_receive(:run)
        @base.find_and_run_match('path')
      end

      it "should clear the console" do
        @base.should_receive(:system).with("clear")
        @base.clear
      end

    end

    context "when running" do
      before(:each) do
        @base.stub!(:command).and_return('echo')
        @base.stub!(:matches).and_return(['spec/path'])
      end
      
      it "should clear the console" do
        @base.stub(:system)
        @base.should_receive(:clear)
        @base.run
      end

      it "should run the tests" do
        @base.stub(:clear)
        @base.should_receive(:system).once
        @base.run
      end
    end
  end
end
