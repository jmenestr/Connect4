module Connect4
  class HumanPlayer

    def initialize(name,marker)
      @marker = marker
      @name = name
      @computer = false
    end

    attr_reader :name, :marker, :computer
  end
end