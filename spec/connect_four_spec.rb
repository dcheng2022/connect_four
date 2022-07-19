require './lib/connect_four.rb'

describe ConnectFour do
  describe '#validate_input' do
    subject(:game_input) { described_class.new('O') }

    context 'when invalid input is given before valid input' do
      before do
        invalid_input = 'a a'
        valid_input = '3'
        allow(game_input).to receive(:gets).and_return(invalid_input, valid_input)
      end

      it 'displays an error message' do
        error_message = 'Invalid input! Please enter a number specifying your desired column.'
        expect(game_input).to receive(:puts).with(error_message).once
        game_input.validate_input
      end
    end

    context 'when two invalid inputs are given before valid input' do
      before do
        invalid_one = '9'
        invalid_two = ' '
        valid_input = '7'
        allow(game_input).to receive(:gets).and_return(invalid_one, invalid_two, valid_input)
      end

      it 'displays error message twice' do
        error_message = 'Invalid input! Please enter a number specifying your desired column.'
        expect(game_input).to receive(:puts).with(error_message).twice
        game_input.validate_input
      end
    end
  end

  describe '#pieces_in_column' do
    subject(:game_column) { described_class.new('o') }

    context 'when given an empty column' do
      it 'returns 0' do
        column_number = 5
        pieces = game_column.pieces_in_column(column_number)
        expect(pieces).to eq(0)
      end
    end
  end

  describe '#place_piece' do
    subject(:game_place) { described_class.new('o') }

    context 'when input is column 1 and column is empty' do
      before do
        valid_input = 1
        column_pieces = 0
        allow(game_place).to receive(:validate_input).and_return(valid_input)
        allow(game_place).to receive(:pieces_in_column).and_return(column_pieces)
      end

      it 'returns [5, 0] as position of piece' do
        position = [5, 0]
        result = game_place.place_piece
        expect(result).to eq(position)
      end
    end

    context 'when input is column 1 and column has 1 piece' do
      before do
        valid_input = 1
        column_pieces = 1
        allow(game_place).to receive(:validate_input).and_return(valid_input)
        allow(game_place).to receive(:pieces_in_column).and_return(column_pieces)
      end

      it 'returns [4, 0] as position of piece' do
        position = [4, 0]
        result = game_place.place_piece
        expect(result).to eq(position)
      end
    end

    context 'when input is column 1 and column has 2 pieces' do
      before do
        valid_input = 1
        column_pieces = 2
        allow(game_place).to receive(:validate_input).and_return(valid_input)
        allow(game_place).to receive(:pieces_in_column).and_return(column_pieces)
      end

      it 'returns [3, 0] as position of piece' do
        position = [3, 0]
        result = game_place.place_piece
        expect(result).to eq(position)
      end
    end

    context 'when input is column 2 and column is empty' do
      before do
        valid_input = 2
        column_pieces = 0
        allow(game_place).to receive(:validate_input).and_return(valid_input)
        allow(game_place).to receive(:pieces_in_column).and_return(column_pieces)
      end

      it 'returns [5, 1] as position of piece' do
        position = [5, 1]
        result = game_place.place_piece
        expect(result).to eq(position)
      end
    end

    context 'when input is column 2 and column has 1 piece' do
      before do
        valid_input = 2
        column_pieces = 1
        allow(game_place).to receive(:validate_input).and_return(valid_input)
        allow(game_place).to receive(:pieces_in_column).and_return(column_pieces)
      end

      it 'returns [4, 1] as position of piece' do
        position = [4, 1]
        result = game_place.place_piece
        expect(result).to eq(position)
      end
    end

    context 'when input is column 3 and column is empty' do
      before do
        valid_input = 3
        column_pieces = 0
        allow(game_place).to receive(:validate_input).and_return(valid_input)
        allow(game_place).to receive(:pieces_in_column).and_return(column_pieces)
      end

      it 'returns [5, 2] as position of piece' do
        position = [5, 2]
        result = game_place.place_piece
        expect(result).to eq(position)
      end
    end

    context 'when input is column 3 and column has 2 pieces' do
      before do
        valid_input = 3
        column_pieces = 2
        allow(game_place).to receive(:validate_input).and_return(valid_input)
        allow(game_place).to receive(:pieces_in_column).and_return(column_pieces)
      end

      it 'returns [3, 2] as position of piece' do
        position = [3, 2]
        result = game_place.place_piece
        expect(result).to eq(position)
      end
    end

    context 'when input is column 5 and column has 2 pieces' do
      before do
        valid_input = 5
        column_pieces = 2
        allow(game_place).to receive(:validate_input).and_return(valid_input)
        allow(game_place).to receive(:pieces_in_column).and_return(column_pieces)
      end

      it 'returns [3, 4] as position of piece' do
        position = [3, 4]
        result = game_place.place_piece
        expect(result).to eq(position)
      end
    end

    context 'when column 4 is full' do
      before do
        valid_input = 4
        column_pieces = 6
        allow(game_place).to receive(:validate_input).and_return(valid_input)
        allow(game_place).to receive(:pieces_in_column).and_return(column_pieces)
      end

      it 'displays an error message' do
        error_message = 'This column is full! Please select another column for your piece.'
        expect(game_place).to receive(:puts).with(error_message).once
        game_place.place_piece
      end
    end
  end

  describe '#game_draw?' do
    subject(:game_draw) { described_class.new('o') }
    described_class.reset_board

    context 'when all spots in board are empty' do
      it 'returns nil' do
        expect(game_draw).not_to be_game_draw
      end
    end
  end

  describe '#game_win?' do
    subject(:game_win) { described_class.new('o') }

    context 'when there are four matching pieces placed in a row' do
      before do
        valid_input = 4
        column_pieces = 0
        allow(game_win).to receive(:validate_input).and_return(valid_input)
        allow(game_win).to receive(:pieces_in_column).and_return(column_pieces)
      end

      it 'returns true' do
        expect(game_win).to be_game_win
      end
    end

    context 'when there are four matching pieces placed in a column' do
      before do
        valid_input = 1
        column_pieces = 3
        allow(game_win).to receive(:validate_input).and_return(valid_input)
        allow(game_win).to receive(:pieces_in_column).and_return(column_pieces)
      end

      it 'returns true' do
        expect(game_win).to be_game_win
      end
    end

    context 'when there are four matching pieces placed in a diagonal' do
      before do
        valid_input = 4
        column_pieces = 3
        allow(game_win).to receive(:validate_input).and_return(valid_input)
        allow(game_win).to receive(:pieces_in_column).and_return(column_pieces)
      end

      it 'returns true' do
        expect(game_win).to be_game_win
      end
    end

    context 'when there are not four matching pieces in a row, column, or diagonal' do
      before do
        valid_input = 4
        column_pieces = 5
        allow(game_win).to receive(:validate_input).and_return(valid_input)
        allow(game_win).to receive(:pieces_in_column).and_return(column_pieces)
      end

      it 'returns false' do
        expect(game_win).not_to be_game_win
      end
    end
  end
end
