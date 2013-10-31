require 'spec_helper'

describe HaproxyWeight::Line do
  context "valid_weight?" do
    it "accepts integer weight value from 0 to 255" do
      HaproxyWeight::Line.valid_weight?(50).should == true
      HaproxyWeight::Line.valid_weight?(0).should == true
      HaproxyWeight::Line.valid_weight?(255).should == true
    end

    it "does not accept negative integer weight" do
      HaproxyWeight::Line.valid_weight?(-50).should == false
    end

    it "accepts string weight values from 0 to 255" do
      HaproxyWeight::Line.valid_weight?("50").should == true
      HaproxyWeight::Line.valid_weight?("0").should == true
      HaproxyWeight::Line.valid_weight?("255").should == true
    end

    it "does not accept floating point weights" do
      HaproxyWeight::Line.valid_weight?("4.5").should == false
      HaproxyWeight::Line.valid_weight?(4.5).should == false
    end

    it "does not accept alphanumeric weights" do
      HaproxyWeight::Line.valid_weight?("hello").should == false
    end

    it "handles hashes, arrays, etc gracefully" do
      HaproxyWeight::Line.valid_weight?({}).should == false
      HaproxyWeight::Line.valid_weight?([]).should == false
      HaproxyWeight::Line.valid_weight?(Object.new).should == false
    end
  end

  context "server_name" do
    it "returns the value immediately after the server keyword" do
      HaproxyWeight::Line.new("server my_server").server_name.should == "my_server"
    end

    it "returns nil for invalid lines" do
      HaproxyWeight::Line.new("my_server").server_name.should == nil
    end
  end

  context "weight" do
    it "returns the first integer value after the weight keyword" do
      HaproxyWeight::Line.new("weight 50").weight.should == 50
    end

    it "returns nil if there is no weight keyword" do
      HaproxyWeight::Line.new("server foo").weight.should == nil
    end

    it "does not return the keyword after the weight value" do
      HaproxyWeight::Line.new("weight 50 check").weight.should == 50
    end

    it "accepts keywords with arguments before the weight keyword" do
      HaproxyWeight::Line.new("server foo weight 25").weight.should == 25
    end
  end

  context "to_s" do
    it "returns the line value as a string" do
      HaproxyWeight::Line.new("my line").to_s.should == "my line"
    end
  end

  context "valid?" do
    it "matches lines that start with server and a server name" do
      line = HaproxyWeight::Line.new("server my_server")
      line.is_server_line?.should == true
    end

    it "matches lines that start with whitespace" do
      line = HaproxyWeight::Line.new("\t server my_server")
      line.is_server_line?.should == true
    end

    it "does not match lines that don't start with server and a name" do
      HaproxyWeight::Line.new("server").is_server_line?.should == false
      HaproxyWeight::Line.new("something else server").is_server_line?.should == false
    end

    it "matches line that have stuff after the server and name" do
      HaproxyWeight::Line.new("\t server my_server lots of other options").is_server_line?.should == true
    end
  end
end
