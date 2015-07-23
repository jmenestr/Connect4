require_relative 'board'
require_relative 'human_player'

module Connect4
  class Game
    attr_accessor :game_board, :current_player, :other_player

    def initialize(player1,player2)
      @game_board = Board.new
      @players = [player1,player2].shuffle #Need to make player classes
      @current_player = @players[0]
      @other_player = @players[1]
    end

    def switch_players!
      @current_player, @other_player = @other_player, @current_player
    end

    def play
      loop do
        @game_board.print_board
        puts "Please make a move #{@current_player.name} (#{@current_player.marker})"
        input = gets.chomp.split(" ")
        col = input[0].to_i
        marker = @current_player.marker
           # Hardcode marker for now
        @game_board.drop_piece!(col,marker)
        #print @game_board.get_columns
        #print "\n"
        #print @game_board.get_rows
        #print "\n"
        #print @game_board.get_diagonals
        #print "\n"
        if check_win?(marker)
          @game_board.print_board
          puts "#{@current_player.name} has won!"
          break
        end
        switch_players!
      end
    end

    def check_vertical_win?(marker)
      #Check for Vertical win logic walkthrough
      # 1. Get all columns from the @game_board
      # 2. Iterate through each column
      #   3. Iterate through each space of column
      #   4. if space == marker 
      #         add 1 to in_a_row int
      #      else
      #         reset in_a_row int to 0
      #    check to see if in_a_row == 4
      #    return true if yes
      #   
      in_a_row = 0
      colums = @game_board.get_columns
      colums.each do |column|
        column.each do |space|
          if space == marker
            in_a_row += 1
          else
            in_a_row = 0
          end
          return true if in_a_row == 4
        end
      end
      false
    end

    def check_horizontal_win?(marker)
      in_a_row = 0
      rows = @game_board.get_rows
      rows.each do |row|
        row.each do |space|
          if space == marker
            in_a_row += 1
          else
            in_a_row = 0
          end
          return true if in_a_row == 4
        end
      end
      false
    end

    def check_diagonal_win?(marker)
      #gets a list of all diagonals from the board and checks to see
      # if any are a winning row
      diagonals = @game_board.get_diagonals
      match_marker = Proc.new {|space| space == marker}
      diagonals.any? {|diag| diag.all?(&match_marker) }
    end

    def check_win?(marker)
      return true if check_vertical_win?(marker) or 
                      check_horizontal_win?(marker) or 
                      check_diagonal_win?(marker)

      false
    end

  end

end

x = Connect4::Game.new(Connect4::HumanPlayer.new("Justin","X"),
                       Connect4::HumanPlayer.new("Kristen","O"))
x.play
