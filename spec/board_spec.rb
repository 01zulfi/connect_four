# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    subject(:board_init) { described_class.new }

    context 'when board is not given' do
      it 'creates a new board' do
        board = board_init.board
        expect(board).to match_array(Array.new(6) { Array.new(7) })
      end
    end
  end

  describe '#place_color' do
    subject(:board_color) { described_class.new }

    context 'when non-integer column is given' do
      it 'returns false' do
        flag = board_color.place_color('a', 'red')
        expect(flag).to be false
      end
    end

    context 'when invalid column number is given' do
      it 'returns false' do
        flag = board_color.place_color(8, 'black')
        expect(flag).to be false
      end
    end

    context 'when valid column number is given' do
      context 'when column is empty' do
        it 'places color at the end of the column' do
          board_color.place_color(0, 'red')
          board = board_color.board
          expect(board[5][0]).to eq('red')
        end

        it 'returns true' do
          flag = board_color.place_color(0, 'red')
          expect(flag).to be true
        end
      end

      context 'when column is full' do
        it 'returns false' do
          board_color.place_color(0, 'red')
          board_color.place_color(0, 'red')
          board_color.place_color(0, 'red')
          board_color.place_color(0, 'red')
          board_color.place_color(0, 'red')
          board_color.place_color(0, 'red')
          flag = board_color.place_color(0, 'red')
          expect(flag).to be false
        end
      end

      context 'when column is slightly full/empty' do
        before do
          board_color.place_color(3, 'red')
          board_color.place_color(3, 'red')
          board_color.place_color(3, 'red')
        end

        it 'places color at the last empty row of the column' do
          board_color.place_color(3, 'red')
          board = board_color.board
          expect(board[3][3]).to eq('red')
        end

        it 'returns true' do
          flag = board_color.place_color(3, 'red')
          expect(flag).to be true
        end
      end
    end
  end
end
