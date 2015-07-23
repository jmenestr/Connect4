module Connect4
  class Board

    # Board class handles the array structure of the game
    # including:
    #   checking to see if point is contained in the board
    #   handeling dropping a piece onto the gameboard
    #   printing the board
    #   returning the piece at a given location
    attr_accessor :board
    def initialize
      @rows = 6
      @columns = 7
      @board = Array.new(@rows*@columns,nil) 
    end

    def is_inside?(x,y)
      x >= 0 and x < @columns and y >= 0 and y < @rows
    end

    def is_empty?(space)
      @board[space].nil?

    end

    def has_piece?(x,y)

    end

    def drop_piece!(col,marker)
      # col will be in the range of 0-6  
      col_spaces = (0...@rows).map { |row| col+row*@columns  }.reverse
      first_empty = col_spaces.find {|space| is_empty?(space)}
      @board[first_empty] = marker
    end

    def get_columns
      columns = []
      (0...@columns).each do |col|
        columns << (0...@rows).map { |row| col+row*@columns  }
      end
      columns
    end

    def get_rows
      rows = []
      (0...@rows).each do |row|
        rows << (0...@columns).map { |col| col+row*@columns  }
      end
      rows
    end

    def get_piece(x,y)
      @board[x+@columns*y]
    end

    def print_board
      col_sep = " | " 
      row_sep = "\n" + "----"*@columns + "\n"
      output = [(0...@columns).to_a.join(col_sep)]
      (0...@rows).each do |y|
        row = []
        (0...@columns).each do |x|
          if @board[x+@columns*y].nil?
          row << " "
          else
          row << @board[x+@columns*y]
          end     
        end
        output << row.join(col_sep)
      end
      puts output.join(row_sep)
    end

  end
end

x = Connect4::Board.new
loop do
  puts "Make Move"
  input = gets.chomp.split(" ")
  col = input[0].to_i
  marker = input[1]
  x.drop_piece!(col,marker)
  print x.get_rows + "\n"
  print x.get_columns
end