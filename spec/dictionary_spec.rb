require 'dictionary'

describe Dictionary do

  before do
    @d = Dictionary.new("apple\nbe\nbees\n")
  end

  describe "#word_count" do
    it "counts the words loaded" do
      @d.word_count.should == 3
    end
  end

  describe "#is_word?" do
    it "is true when the given string is in the dictionary" do
      @d.is_word?("apple").should be_true
      @d.is_word?("be").should be_true
      @d.is_word?("bees").should be_true
    end
    it "is false when the string is not in the dictionary" do
      @d.is_word?("pear").should be_false      
    end
  end

  describe "#is_word_prefix?" do
    it "is true when string is a prefix" do
      @d.is_word_prefix?("app").should be_true
    end
    it "is true when string is a prefix and a complete word" do
      @d.is_word_prefix?("be").should be_true
    end
    it "is false when the string is not in the dictionary" do
      @d.is_word_prefix?("pear").should be_false      
    end
    it "is false when the string is a complete word and not a prefix for another word" do
      @d.is_word_prefix?("apple").should be_false      
    end
  end

end