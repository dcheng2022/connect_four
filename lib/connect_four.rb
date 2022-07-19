require 'pry-byebug'

class ConnectFour
  @@board = Array.new(6) { Array.new(7, ' ') }

  def initialize(color)
    @color = color
  end

  def self.reset_board
    @@board = Array.new(6) { Array.new(7, ' ') }
  end

  def place_piece
    column = validate_input
    column_pieces = pieces_in_column(column)
    @@board[5 - column_pieces][column - 1] = @color
    [5 - column_pieces, column - 1]
  end

  def validate_input
    loop do
      input = gets.chomp.to_i
      return input if (1..7).include?(input) && pieces_in_column(input) < 6

      puts 'Invalid column selection. Please try again.'
    end
  end

  def pieces_in_column(column)
    pieces = 0
    @@board.each { |row| pieces += 1 unless row[column - 1] == ' ' }
    pieces
  end

  def game_draw?
    slots = @@board.flatten
    return true if slots.none? { |slot| slot == ' ' }
  end

  def game_win?
    piece_pos = place_piece
    row = piece_pos[0]
    column = piece_pos[1]
    matches = 0

    @@board[row].each do |slot|
      matches = slot == @color ? matches + 1 : 0
      return true if matches == 4
    end

    @@board.each do |row|
      matches = row[column] == @color ? matches + 1 : 0
      return true if matches == 4
    end

    shift_array = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
    shift_array.each do |shift|
      matches = 0
      shift_row = row
      shift_column = column
      loop do
        break unless (0..5).include?(shift_row) && (0..6).include?(shift_column)

        matches = @@board[shift_row][shift_column] == @color ? matches + 1 : 0
        shift_row += shift[0]
        shift_column += shift[1]
      end
      return true if matches == 4
    end
    false
  end

  private

  def self.print_board
    puts "       1   2   3   4   5   6   7\n     —————————————————————————————"
    @@board.each_with_index do |row, idx|
      print '     | '
      row.each { |slot| print "#{slot} | " }
      print "\n     —————————————————————————————\n"
    end
  end
end
