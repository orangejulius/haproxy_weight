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
end
