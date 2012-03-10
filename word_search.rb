require File.dirname(__FILE__) + '/lib/word_search'
require File.dirname(__FILE__) + '/lib/letter_grid'
require File.dirname(__FILE__) + '/lib/dictionary'

require 'benchmark'


ws = WordSearch.new("periodic_table.csv", "/usr/share/dict/words")

w = ''
Benchmark.bmbm do |b|
  b.report("letter grid search - my method - 1000x") do
    1000.times do
      w = ws.find_longest_word
    end
  end
end
puts "Found: " + w


w = ''
ws.set_dictionary_sorted_by_length
Benchmark.bmbm do |b|
  b.report("letter grid search - method 2 - just once") do
    1.times do
      w = ws.find_longest_word_method_2
    end
  end
end
puts "Found: " + w
