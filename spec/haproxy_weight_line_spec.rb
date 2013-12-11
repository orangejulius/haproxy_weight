require 'spec_helper'

describe HaproxyWeight::Line do
  subject(:line) { HaproxyWeight::Line }
  context "valid_weight?" do
    it "accepts integer weight value from 0 to 255" do
      line.valid_weight?(50).should == true
      line.valid_weight?(0).should == true
      line.valid_weight?(255).should == true
    end

    it "does not accept negative integer weight" do
      line.valid_weight?(-50).should == false
    end

    it "accepts string weight values from 0 to 255" do
      line.valid_weight?("50").should == true
      line.valid_weight?("0").should == true
      line.valid_weight?("255").should == true
    end

    it "does not accept floating point weights" do
      line.valid_weight?("4.5").should == false
      line.valid_weight?(4.5).should == false
    end

    it "does not accept alphanumeric weights" do
      line.valid_weight?("hello").should == false
    end

    it "handles hashes, arrays, etc gracefully" do
      line.valid_weight?({}).should == false
      line.valid_weight?([]).should == false
      line.valid_weight?(Object.new).should == false
    end
  end

  context "server_name" do
    it "returns the value immediately after the server keyword" do
      line.new("server my_server").server_name.should == "my_server"
    end

    it "returns nil for invalid lines" do
      line.new("my_server").server_name.should == nil
    end

    it "handles dashes within server names" do
      line.new("server my-server").server_name.should == "my-server"
    end
  end

  context "weight" do
    it "returns the first integer value after the weight keyword" do
      line.new("weight 50").weight.should == 50
    end

    it "returns nil if there is no weight keyword" do
      line.new("server foo").weight.should == nil
    end

    it "does not return the keyword after the weight value" do
      line.new("weight 50 check").weight.should == 50
    end

    it "accepts keywords with arguments before the weight keyword" do
      line.new("server foo weight 25").weight.should == 25
    end
  end

  context "weight=" do
    it "changes the weight value of the line" do
      l = line.new("weight 50")
      l.weight = 25
      l.to_s.should == "weight 25"
    end

    it "won't change the weight if the new value is not a valid weight" do
      l = line.new("weight 50")
      expect { l.weight = -5}.to raise_error(RuntimeError, "weight must be an integer between 0 and 255")
      l.to_s.should == "weight 50"
    end
  end

  context "to_s" do
    it "returns the line value as a string" do
      line.new("my line").to_s.should == "my line"
    end
  end

  context "valid?" do
    it "matches lines that start with server and a server name" do
      l = line.new("server my_server")
      l.is_server_line?.should == true
    end

    it "matches lines that start with whitespace" do
      l = line.new("\t server my_server")
      l.is_server_line?.should == true
    end

    it "does not match lines that don't start with server and a name" do
      line.new("server").is_server_line?.should == false
      line.new("something else server").is_server_line?.should == false
    end

    it "matches line that have stuff after the server and name" do
      line.new("\t server my_server lots of other options").is_server_line?.should == true
    end
  end
end
