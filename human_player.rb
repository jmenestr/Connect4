module Connect4
  class HumanPlayer

    def initialize(name,marker)
      @marker = marker
      @name = name
    end

    attr_reader :name, :marker
  end
end