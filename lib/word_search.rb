require 'csv'

class WordSearch

  def initialize(grid_file, dictionary_file)
    @letter_grid = LetterGrid.new
    CSV.foreach(grid_file) do |row|
      @letter_grid.add_row(row)
    end
    p "Loaded grid with #{@letter_grid.row_count} rows, #{@letter_grid.column_counts.inspect} cols."

    dict = File.read(dictionary_file)
    @dictionary = Dictionary.new(dict)
    p "Loaded dictionary with #{@dictionary.word_count} words."
  end

  def find_longest_word
    longest_word = ''
    @letter_grid.check_all_strings do |str|
      if @dictionary.is_word?(str) && str.length > longest_word.length
        longest_word = str
      end
      @dictionary.is_word_prefix?(str)
    end
    longest_word
  end

  # alternate method 
  # call set_dictionary_sorted_by_length first
  def find_longest_word_method_2

    @dictionary.sorted_words.each do |w|
      @letter_grid.check_all_strings do |str|
        b = w.start_with?(str)
        if b && (w == str)
          return w
        end
        b
      end
    end
  end


  def set_dictionary_sorted_by_length
    words_by_length = @dictionary.sorted_words.sort { |a,b| a.length <=> b.length }.reverse
    @dictionary.sorted_words = words_by_length
  end

end