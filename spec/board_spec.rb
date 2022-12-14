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

  describe '#horizontal_win?' do
    subject(:board_horizontal) { described_class.new }

    context 'when no move is played' do
      it 'red does not win' do
        won = board_horizontal.horizontal_win?('red')
        expect(won).to be false
      end

      it 'black does not win' do
        won = board_horizontal.horizontal_win?('black')
        expect(won).to be false
      end
    end

    context 'when row has only red (or black) markers' do
      context 'when red has three or less consecutive markers' do
        context 'in any row' do
          it 'returns false' do
            board_horizontal.place_color(0, 'red')
            board_horizontal.place_color(1, 'red')
            board_horizontal.place_color(2, 'red')
            won = board_horizontal.horizontal_win?('red')
            expect(won).to be false
          end
        end

        context 'in any row x2' do
          it 'returns false' do
            board_horizontal.place_color(4, 'red')
            board_horizontal.place_color(5, 'red')
            won = board_horizontal.horizontal_win?('red')
            expect(won).to be false
          end
        end
      end

      context 'when red has four consecutive markers' do
        context 'in any row' do
          it 'returns true' do
            board_horizontal.place_color(0, 'red')
            board_horizontal.place_color(1, 'red')
            board_horizontal.place_color(2, 'red')
            board_horizontal.place_color(3, 'red')
            won = board_horizontal.horizontal_win?('red')
            expect(won).to be true
          end
        end

        context 'in any row x2' do
          it 'returns true' do
            board_horizontal.place_color(3, 'red')
            board_horizontal.place_color(4, 'red')
            board_horizontal.place_color(5, 'red')
            board_horizontal.place_color(6, 'red')
            won = board_horizontal.horizontal_win?('red')
            expect(won).to be true
          end
        end
      end
    end

    context 'when row has red & black markers' do
      context 'in order rbrrbb' do
        before do
          board_horizontal.place_color(0, 'red')
          board_horizontal.place_color(1, 'black')
          board_horizontal.place_color(2, 'red')
          board_horizontal.place_color(3, 'black')
          board_horizontal.place_color(4, 'red')
          board_horizontal.place_color(5, 'black')
          board_horizontal.place_color(6, 'black')
        end

        it 'red does not win' do
          won = board_horizontal.horizontal_win?('red')
          expect(won).to be false
        end

        it 'black does not win' do
          won = board_horizontal.horizontal_win?('black')
          expect(won).to be false
        end
      end

      context 'in order bbbrrrr' do
        before do
          board_horizontal.place_color(0, 'black')
          board_horizontal.place_color(1, 'black')
          board_horizontal.place_color(2, 'black')
          board_horizontal.place_color(3, 'red')
          board_horizontal.place_color(4, 'red')
          board_horizontal.place_color(5, 'red')
          board_horizontal.place_color(6, 'red')
        end

        it 'red wins' do
          won = board_horizontal.horizontal_win?('red')
          expect(won).to be true
        end

        it 'black does not win' do
          won = board_horizontal.horizontal_win?('black')
          expect(won).to be false
        end
      end
    end
  end

  describe '#vertical_win?' do
    subject(:board_vertical) { described_class.new }

    context 'when no move is played' do
      it 'red does not win' do
        won = board_vertical.vertical_win?('red')
        expect(won).to be false
      end

      it 'black does not win' do
        won = board_vertical.vertical_win?('black')
        expect(won).to be false
      end
    end

    context 'when column has only red (or black) markers' do
      context 'when red has three or less consecutive markers' do
        context 'in any column' do
          it 'returns false' do
            board_vertical.place_color(0, 'red')
            board_vertical.place_color(0, 'red')
            board_vertical.place_color(0, 'red')
            won = board_vertical.vertical_win?('red')
            expect(won).to be false
          end
        end

        context 'in any column x2' do
          it 'returns false' do
            board_vertical.place_color(3, 'red')
            board_vertical.place_color(3, 'red')
            won = board_vertical.vertical_win?('red')
            expect(won).to be false
          end
        end
      end

      context 'when red has four consecutive markers' do
        context 'in any column' do
          it 'returns true' do
            board_vertical.place_color(0, 'red')
            board_vertical.place_color(0, 'red')
            board_vertical.place_color(0, 'red')
            board_vertical.place_color(0, 'red')
            won = board_vertical.vertical_win?('red')
            expect(won).to be true
          end
        end

        context 'in any column x2' do
          it 'returns true' do
            board_vertical.place_color(3, 'red')
            board_vertical.place_color(3, 'red')
            board_vertical.place_color(3, 'red')
            board_vertical.place_color(3, 'red')
            won = board_vertical.vertical_win?('red')
            expect(won).to be true
          end
        end
      end
    end

    context 'when column has red & black markers' do
      context 'in order rbrrbb' do
        before do
          board_vertical.place_color(0, 'red')
          board_vertical.place_color(0, 'black')
          board_vertical.place_color(0, 'red')
          board_vertical.place_color(0, 'red')
          board_vertical.place_color(0, 'black')
        end

        it 'red does not win' do
          won = board_vertical.vertical_win?('red')
          expect(won).to be false
        end

        it 'black does not win' do
          won = board_vertical.vertical_win?('black')
          expect(won).to be false
        end
      end

      context 'in order brbbbb' do
        before do
          board_vertical.place_color(6, 'black')
          board_vertical.place_color(6, 'red')
          board_vertical.place_color(6, 'black')
          board_vertical.place_color(6, 'black')
          board_vertical.place_color(6, 'black')
          board_vertical.place_color(6, 'black')
        end

        it 'red does not win' do
          won = board_vertical.vertical_win?('red')
          expect(won).to be false
        end

        it 'black wins' do
          won = board_vertical.vertical_win?('black')
          expect(won).to be true
        end
      end
    end
  end

  describe '#diagonal_win?' do
    subject(:board_diagonal) { described_class.new }

    context 'when no move is played' do
      it 'red does not win' do
        won = board_diagonal.diagonal_win?('red')
        expect(won).to be false
      end

      it 'black does not win' do
        won = board_diagonal.diagonal_win?('black')
        expect(won).to be false
      end
    end

    context 'when diagonal has only red (or black) markers' do
      context 'when red has three or less consecutive markers' do
        context 'in any diagonal' do
          it 'returns false' do
            board_diagonal.place_color(0, 'red')
            board_diagonal.place_color(1, 'black')
            board_diagonal.place_color(1, 'red')
            board_diagonal.place_color(2, 'black')
            board_diagonal.place_color(2, 'black')
            board_diagonal.place_color(2, 'red')
            won = board_diagonal.diagonal_win?('red')
            expect(won).to be false
          end
        end

        context 'in any diagonal x2' do
          it 'returns false' do
            board_diagonal.place_color(3, 'red')
            board_diagonal.place_color(4, 'black')
            board_diagonal.place_color(4, 'red')
            won = board_diagonal.diagonal_win?('red')
            expect(won).to be false
          end
        end
      end

      context 'when red has four consecutive markers' do
        context 'in any diagonal' do
          it 'returns true' do
            board_diagonal.place_color(0, 'red')
            board_diagonal.place_color(1, 'black')
            board_diagonal.place_color(1, 'red')
            board_diagonal.place_color(2, 'black')
            board_diagonal.place_color(2, 'black')
            board_diagonal.place_color(2, 'red')
            board_diagonal.place_color(3, 'black')
            board_diagonal.place_color(3, 'black')
            board_diagonal.place_color(3, 'black')
            board_diagonal.place_color(3, 'red')
            won = board_diagonal.diagonal_win?('red')
            expect(won).to be true
          end
        end

        context 'in any diagonal x2' do
          it 'returns true' do
            board_diagonal.place_color(3, 'black')
            board_diagonal.place_color(3, 'red')
            board_diagonal.place_color(4, 'black')
            board_diagonal.place_color(4, 'black')
            board_diagonal.place_color(4, 'red')
            board_diagonal.place_color(5, 'black')
            board_diagonal.place_color(5, 'black')
            board_diagonal.place_color(5, 'black')
            board_diagonal.place_color(5, 'red')
            board_diagonal.place_color(6, 'black')
            board_diagonal.place_color(6, 'black')
            board_diagonal.place_color(6, 'black')
            board_diagonal.place_color(6, 'black')
            board_diagonal.place_color(6, 'red')
            won = board_diagonal.diagonal_win?('red')
            expect(won).to be true
          end
        end
      end
    end

    context 'when diagonal has red & black markers' do
      context 'in order rbrrrr' do
        before do
          board_diagonal.place_color(0, 'red')
          board_diagonal.place_color(1, 'black')
          board_diagonal.place_color(1, 'black')
          board_diagonal.place_color(2, 'red')
          board_diagonal.place_color(2, 'red')
          board_diagonal.place_color(2, 'red')
          board_diagonal.place_color(3, 'red')
          board_diagonal.place_color(3, 'red')
          board_diagonal.place_color(3, 'red')
          board_diagonal.place_color(3, 'red')
          board_diagonal.place_color(4, 'red')
          board_diagonal.place_color(4, 'red')
          board_diagonal.place_color(4, 'red')
          board_diagonal.place_color(4, 'red')
          board_diagonal.place_color(4, 'red')
          board_diagonal.place_color(5, 'red')
          board_diagonal.place_color(5, 'red')
          board_diagonal.place_color(5, 'red')
          board_diagonal.place_color(5, 'red')
          board_diagonal.place_color(5, 'red')
          board_diagonal.place_color(5, 'red')
        end

        it 'red wins' do
          won = board_diagonal.diagonal_win?('red')
          expect(won).to be true
        end

        it 'black does not win' do
          won = board_diagonal.diagonal_win?('black')
          expect(won).to be false
        end
      end
    end
  end

  describe '#won' do
    subject(:board_won) { described_class.new }

    before do
      allow(board_won).to receive(:horizontal_win?).and_return(false)
      allow(board_won).to receive(:vertical_win?).and_return(false)
      allow(board_won).to receive(:diagonal_win?).and_return(false)
    end

    context 'when red (or black) has h,v,d win' do
      it 'returns true' do
        allow(board_won).to receive(:horizontal_win?).and_return(true)
        allow(board_won).to receive(:vertical_win?).and_return(true)
        allow(board_won).to receive(:diagonal_win?).and_return(true)
        expect(board_won).to be_won('red')
      end
    end

    context 'when red (or black) has no win' do
      it 'returns false' do
        expect(board_won).to_not be_won('red')
      end
    end

    context 'when red (or black) has h,v win' do
      it 'returns true' do
        allow(board_won).to receive(:horizontal_win?).and_return(true)
        allow(board_won).to receive(:vertical_win?).and_return(true)
        expect(board_won).to be_won('red')
      end
    end

    context 'when red (or black) has h,d win' do
      it 'returns true' do
        allow(board_won).to receive(:horizontal_win?).and_return(true)
        allow(board_won).to receive(:diagonal_win?).and_return(true)
        expect(board_won).to be_won('red')
      end
    end

    context 'when red (or black) has v,d win' do
      it 'returns true' do
        allow(board_won).to receive(:vertical_win?).and_return(true)
        allow(board_won).to receive(:diagonal_win?).and_return(true)
        expect(board_won).to be_won('red')
      end
    end
  end

  describe '#full?' do
    context 'when board is filled with markers' do
      board = [%w[red black], %w[black red]]
      subject(:board_full) { described_class.new(board) }

      it 'returns true' do
        expect(board_full).to be_full
      end
    end

    context 'when board is not filled with markers' do
      subject(:board_empty) { described_class.new }

      it 'retrns false' do
        expect(board_empty).to_not be_full
      end
    end

    context 'when board is partially filled with markers' do
      board = [['red', nil], [nil, 'red']]
      subject(:board_partial) { described_class.new(board) }

      it 'returns false' do
        expect(board_partial).to_not be_full
      end
    end
  end
end
