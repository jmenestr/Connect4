
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
        columns << (0...@rows).map { |row| @board[col+row*@columns]  }
      end
      columns
    end

    def get_rows
      rows = []
      (0...@rows).each do |row|
        rows << (0...@columns).map { |col| @board[col+row*@columns]  }
      end
      rows
    end

    def get_diagonals
            #Top Left -> Bottom Right
      # Can't go past col 4 (3)
      # Can't go past row 3 (2)
      
      diagonals = []
      # left_right is an array of the numbers that need to be added
      # to each space to create a diagonal from top left to bottom right
      #   right_left is analgous for top right to bottom left
      left_right = [0,8,16,24]
      right_left = [0,6,12,18]
      # Each possible winning diagonal must be able to have 4
      # spaces. Any rows after the third do no have enough
      # vertical space to create a connect 4 so I limit my 
      # iternation to only those rows which can be winning 
      (0..(@rows-4)).each do |row|

        #Analagous to the rows argument, for winning diagonals
        # from top left to bottom right must have adequate 
        # column space to the right to support 4 columns
        # Thus I limit my left -> right diagonals to the 
        # first 4 columns
        (0..(@columns-4)).each do |column|
          diag = []
          left_right.each do |num_added|
            diag << get_piece(column+num_added,row)
          end
          diagonals << diag
        end

        #Analagous to the above argument, for winning diagonals
        # from rop right to bottom left must have adequate 
        # column space to the left to support 4 columns
        # Thus I limit my right -> left diagonals to the 
        # last 4 columns

        ((@columns-4)...@columns).each do |column|
          diag = []
          right_left.each do |num_added|
            diag << get_piece(column+num_added,row)
          end
          diagonals << diag
        end

      end
      diagonals # returns arry of all diagonals
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


