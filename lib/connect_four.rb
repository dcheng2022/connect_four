require 'pry-byebug'

class ConnectFour
  @@board = Array.new(6) { Array.new(7, ' ') }

  def initialize(color)
    @color = color
  end

  private

  def print_board
    puts "       1   2   3   4   5   6   7\n     —————————————————————————————"
    @@board.each_with_index do |row, idx|
      print '     | '
      row.each { |slot| print "#{slot} | " }
      print "\n     —————————————————————————————\n"
    end
  end
end
