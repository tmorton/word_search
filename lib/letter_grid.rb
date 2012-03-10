class LetterGrid

  def initialize
    @rows ||= []
  end

  def add_row(ar)
    @rows << ar.map { |l| l.downcase if l }
  end

  def row_count
    @rows.length
  end

  def column_counts
    @rows.map { |r| r.length }.uniq
  end


  # Runs through the grid.
  # Yields each string of letters to be made from the grid.  
  # If the block returns false, abandons that direction. 
  def check_all_strings(&block)
    each_cell do |letter, row, col| 
      string = letter
      cont = yield string
      if cont

        check_in_direction(row, col, :up, &block)
        check_in_direction(row, col, :right, &block)
        check_in_direction(row, col, :down, &block)
        check_in_direction(row, col, :left, &block)

      end
    end
  end

private

  def check_in_direction(row, col, direction_method, &block)
    cont = true
    string = letter_at(row, col)
    while cont
      row, col = send(direction_method, row, col)
      l = letter_at(row, col)
      if blank?(l)
        cont = false
      else
        string = string + l
        cont = (yield string)
      end
    end
  end
  
  def letter_at(row, col)
    r = @rows[row]
    r ? r[col] : nil
  end

  # yields for each non-blank cell in the grid
  def each_cell
    @rows.each_with_index do |row_ar, row|
      row_ar.each_with_index do |letter, col|
        if !blank?(letter)
          yield letter, row, col
        end
      end
    end
  end

  def up(row, col)
    [row-1, col]
  end

  def down(row, col)
    [row+1, col]
  end

  def right(row, col)
    [row, col+1]
  end

  def left(row, col)
    [row, col-1]
  end

  def blank?(str)
    str.nil? || str == ''
  end

end