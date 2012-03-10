class Dictionary

  attr_accessor :sorted_words

  # Word_list should already be sorted
  def initialize(word_list)
    @sorted_words = word_list.split("\n").map { |w| w.downcase if w }
  end

  def word_count
    @sorted_words.length
  end

  def is_word?(str)
    index = binary_search(str, 0, word_count-1)
    @sorted_words[index] == str
  end

  def is_word_prefix?(str)
    index = binary_search(str, 0, word_count-1)
    first_word = @sorted_words[index]

    if first_word == str
      next_word = @sorted_words[index+1]
      next_word && next_word.start_with?(str)
    else
      first_word.start_with?(str)
    end

  end

private
  
  # returns the index of the first element >= str
  def binary_search(str, min_index, max_index)
    while min_index < max_index
      check_index = min_index + ((max_index - min_index) / 2).floor
      check = @sorted_words[check_index]
      case str <=> check
      when -1 
        max_index = check_index-1
      when 0
        return check_index
      when 1
        min_index = check_index+1
      end
    end
    min_index
  end

end