require 'pry-byebug'

class ConnectFour
  @@board = Array.new(6) { Array.new(7, ' ') }

  def initialize(color)
    @color = color
  end
end
