module Connect4
  class Game
    attr_accessor :game_board, :current_player, :other_player

    def initialize(player1, player2)
      @game_board = Board.new
      @players = [player1,player2].shuffle #Need to make player classes
      @current_player = @players[0]
      @other_player = @players[1]
    end

    def switch_players!
      @current_player, @other_player = @other_player, @current_player
    end

    def play
      puts "Make Move"
      input = gets.chomp.split(" ")
      col = input[0].to_i
      marker = input[1]
      @game_board.drop_piece!(col,marker)
    end

    def check_vertical_win?
      colums = @game_board.get_columns
      colums.each do |column|
        column.each do |space|
          marker = @game_board[space]
           #checks after current player has played so                                              # we only have to check for one marker
        end
        end
      end
    end

    def check_horizontal_win?
      rows = @game_board.get_rows
    end

    def check_diagonal_win?
    end

    def check_win?
    end



  end
end