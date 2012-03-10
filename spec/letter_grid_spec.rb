require 'letter_grid'

describe LetterGrid do

  let(:lg) { LetterGrid.new }

  describe "#add_row" do
    it "adds a row" do
      lg.row_count.should == 0
      lg.add_row(%w{a c x})
      lg.row_count.should == 1      
    end
  end

  describe "#check_all_strings" do

    it "yields once for each letter in the grid when the block returns false" do
      lg.add_row(%w{a b c})
      lg.add_row(%w{d e f})
      yieldeds = []
      lg.check_all_strings do |s|
        yieldeds << s
        false
      end
      yieldeds.should == %w{a b c d e f}
    end

    it "searches up, down, left and right when the block returns true" do
      lg.add_row(%w{a b c})
      lg.add_row(%w{d e f})
      lg.add_row(%w{g h i})
      yieldeds = []
      lg.check_all_strings do |s|
        yieldeds << s
        s == 'e'
      end
      yieldeds.should == %w{a b c d e eb ef eh ed f g h i}
    end

    it "handles nil cells" do
      lg.add_row(['a', nil, 'c'])
      lg.add_row(%w{d e f})
      lg.add_row(%w{g h i})
      yieldeds = []
      lg.check_all_strings do |s|
        yieldeds << s
        s == 'e'
      end
      yieldeds.should == %w{a c d e ef eh ed f g h i}
    end
  end


  def yielded_to_check_all_strings(lg)
    yieldeds = []
    lg.check_all_strings do |s|
      yieldeds << s
    end
    yieldeds
  end

end

