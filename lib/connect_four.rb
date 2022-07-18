require 'pry-byebug'

class ConnectFour
  @@board = Array.new(6) { Array.new(7, ' ') }

  def initialize(color)
    @color = color
  end

  def validate_input
    loop do
      input = gets.chomp
      return input if (1..7).include?(input.to_i)

      puts 'Invalid input! Please enter a number specifying your desired column.'
    end
  end

  def pieces_in_column(column)
    pieces = 0
    @@board.each { |row| pieces += 1 if row[column - 1] == @color }
    pieces
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
