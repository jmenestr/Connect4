require_relative 'board'
require_relative 'human_player'
require_relative 'computer'

module Connect4
  class Game
    attr_accessor :board, :current_player, :other_player

    def initialize(player1,player2)
      @board = Board.new
      @players = [player1,player2].shuffle #Need to make player classes
      @current_player = @players[0]
      @other_player = @players[1]
    end

    def switch_players!
      @current_player, @other_player = @other_player, @current_player
    end

    def play
      loop do

        @board.print_board 
       #print @board.get_all_winning_rows    
       #print "\n"
       #print @board.get_all_winning_columns 
        if @current_player.computer
          #Pass in current game state to computer
          puts "Computer's turn."
          current_game = self
          move = @current_player.make_move(current_game) 
        else
          #Human Player move
          puts "Please make a move #{@current_player.name} (#{@current_player.marker})"
          move = gets.chomp.to_i      
        end
        marker = @current_player.marker
        @board.drop_piece!(move,marker)
        if check_win?(@current_player)
          @board.print_board
          puts "#{@current_player.name} has won!"
          break
        end
        switch_players!
      end
    end

    def check_vertical_win?(player)
      #Check for Vertical win logic walkthrough
      # 1. Get all columns from the @board
      # 2. Iterate through each column
      #   3. Iterate through each space of column
      #   4. if space == marker 
      #         add 1 to in_a_row int
      #      else
      #         reset in_a_row int to 0
      #    check to see if in_a_row == 4
      #    return true if yes
      #   
      return true if @board.get_all_winning_columns.any? {|win| win.all?{ |space| space == player.marker}}
      false
    end

    def check_horizontal_win?(player)
      return true if @board.get_all_winning_rows.any? {|win| win.all?{ |space| space == player.marker}}
      false
    end

    def check_diagonal_win?(player)
      #gets a list of all diagonals from the board and checks to see
      # if any are a winning row
      diagonals = @board.get_diagonals
      match_marker = Proc.new {|space| space == player.marker}
      diagonals.any? {|diag| diag.all?(&match_marker) }
    end

    def check_win?(player)
      return true if check_vertical_win?(player) or 
                      check_horizontal_win?(player) or 
                      check_diagonal_win?(player)
      false
    end

    def over?
      #Chec to see if game is over
      @players.any? {|player| check_win?(player)} or board.full?
    end

  end

end

human1  = Connect4::HumanPlayer.new("JUstin","O")
computer2 = Connect4::ComputerPlayer.new("X",human1)
x = Connect4::Game.new(human1,computer2)
x.play
