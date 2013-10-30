require 'spec_helper'

describe HaproxyWeight do
  context "valid_weight?" do
    it "accepts integer weight value from 0 to 255" do
      HaproxyWeight.valid_weight?(50).should == true
      HaproxyWeight.valid_weight?(0).should == true
      HaproxyWeight.valid_weight?(255).should == true
    end

    it "does not accept negative integer weight" do
      HaproxyWeight.valid_weight?(-50).should == false
    end

    it "accepts string weight values from 0 to 255" do
      HaproxyWeight.valid_weight?("50").should == true
      HaproxyWeight.valid_weight?("0").should == true
      HaproxyWeight.valid_weight?("255").should == true
    end

    it "does not accept floating point weights" do
      HaproxyWeight.valid_weight?("4.5").should == false
      HaproxyWeight.valid_weight?(4.5).should == false
    end

    it "does not accept alphanumeric weights" do
      HaproxyWeight.valid_weight?("hello").should == false
    end

    it "handles hashes, arrays, etc gracefully" do
      HaproxyWeight.valid_weight?({}).should == false
      HaproxyWeight.valid_weight?([]).should == false
      HaproxyWeight.valid_weight?(Object.new).should == false
    end
  end

  context "find_weight_value" do
    it "returns the first integer value after the weight keyword" do
      HaproxyWeight.find_weight_value("weight 50").should == 50
    end

    it "returns nil if there is no weight keyword" do
      HaproxyWeight.find_weight_value("server foo").should == nil
    end

    it "does not return the keyword after the weight value" do
      HaproxyWeight.find_weight_value("weight 50 check").should == 50
    end

    it "accepts keywords with arguments before the weight keyword" do
      HaproxyWeight.find_weight_value("server foo weight 25").should == 25
    end
  end

  context "is_server_line?" do
    it "matches lines that start with server and a server name" do
      HaproxyWeight.is_server_line?("server my_server").should == true
    end

    it "matches lines that start with whitespace" do
      HaproxyWeight.is_server_line?("\t server my_server").should == true
    end

    it "does not match lines that don't start with server and a name" do
      HaproxyWeight.is_server_line?("\t my_server").should == false
      HaproxyWeight.is_server_line?("\t something_else server my_server").should == false
    end

    it "matches line that have stuff after the server and name" do
      HaproxyWeight.is_server_line?("\t server my_server lots of other options").should == true
    end
  end
end
