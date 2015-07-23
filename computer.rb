module Connect4
  class ComputerPlayer
    #Outline of computer plaer AI
    #Will use min_max algo to play all positions and 
    # return best possible move
    # Scoring:
    #   if self wins
    #     score = 10
    #   elsif self loses
    #     
    #     
    attr_reader :computer, :marker, :name
    attr_accessor :other_player

    def initialize(marker,other_player = nil)
      @name = "Hal"
      @self = self
      #@current_game = current_game
      @other_player = other_player
      @marker = marker
      @computer = true
      @loop = 0
      
    end

    def score(game)
      #only called if game is over
      # if computer wins, gives 10 points
      # if opponent wins, loses 10 points
      # if board is full, 0
      if game.check_win?(self)
        return 100 
      elsif game.check_win?(@other_player)
        return -100 
      else
        return 0
      end
    end

    def minmax(game,depth)
      #return game score if game is over
      return score(game) if game.over?
      depth += 1

      scores = [] #array of scores
      moves = [] #array of columns to put piece in
      return 0 if depth > 4

      # Populate the scores array recursing if needed
      
      (0...7).to_a.shuffle.each do |col|
        unless game.board.column_full?(col)
          #only proceed if column is not full
          # First clone game state
          new_game_state = game.clone
          new_game_state.board = game.board.clone
          new_game_state.board.board = game.board.board.clone
          #puts "In COl Loop"
          new_game_state.board.print_board
          @loop += 1
          #puts @loop

          #set up current markers and make move
          marker = new_game_state.current_player.marker
          new_game_state.board.drop_piece!(col,marker)
          new_game_state.switch_players!

          scores.push minmax(new_game_state,depth)
          moves.push col
        end
      end

      if game.current_player == @self
        # Max calculation
        max_score_index = scores.each_with_index.max[1]
        @choice = moves[max_score_index]
        #puts "In max calc"
        return scores[max_score_index]
      else
        # Min Score
        min_score_index = scores.each_with_index.min[1]
        @choice = moves[min_score_index]
        #puts "In min Calc"
        return scores[min_score_index]
      end
    end

    def make_move(current_game)
      minmax(current_game,0)
      puts 4
      return @choice
    end

  end
end