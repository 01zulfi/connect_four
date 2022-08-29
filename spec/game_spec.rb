# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/player'
require_relative '../lib/board'

describe Game do
  describe '#player_initialization' do
    subject(:game_player) { described_class.new }
    let(:player_one) { double(Player, name: 'Player One', color: '🔴') }
    let(:player_two) { double(Player, name: 'Player Two', color: '⚫') }

    before do
      allow(game_player).to receive(:player_name_input).with('Player One').and_return('Player One')
      allow(game_player).to receive(:player_name_input).with('Player Two').and_return('Player Two')
    end

    it 'class Game#player_name_input twice with correct arguments' do
      expect(game_player).to receive(:player_name_input).with('Player One').once
      expect(game_player).to receive(:player_name_input).with('Player Two').once
      game_player.player_initialization
    end

    it 'initializes two players' do
      expect(Player).to receive(:new).with('Player One', '🔴').and_return(player_one)
      expect(Player).to receive(:new).with('Player Two', '⚫').and_return(player_two)

      game_player.player_initialization

      expect(game_player.player_one).to eq(player_one)
      expect(game_player.player_two).to eq(player_two)
    end
  end

  describe '#player_name_input' do
    subject(:game_player_input) { described_class.new }
    let(:board) { double(Board) }

    before do 
      allow(game_player_input).to receive(:puts_enter_player_name)
      allow(game_player_input).to receive(:player_name_input_valid?).and_return(true)
      allow(game_player_input).to receive(:puts_player_name_input_invalid)
      allow(game_player_input).to receive(:gets).and_return('Player One')
    end

    it 'calls puts_enter_player_name with same argument' do
      expect(game_player_input).to receive(:puts_enter_player_name).with('Player One')

      game_player_input.player_name_input('Player One')
    end

    context 'when player_name_input_valid? returns true' do
      it 'returns player name' do
        expect(game_player_input).to receive(:player_name_input_valid?).and_return(true)

        expect(game_player_input.player_name_input('Player One')).to eq('Player One')
      end
    end

    context 'when player_name_input_valid? returns false' do
      it 'calls puts_player_name_input_invalid' do
        expect(game_player_input).to receive(:player_name_input_valid?).and_return(false)
        expect(game_player_input).to receive(:puts_player_name_input_invalid)

        game_player_input.player_name_input('Player One')
      end
    end
  end

  describe '#player_name_input_valid?' do
    subject(:game_player_input) { described_class.new }
    let(:board) { double(Board) }

    it 'returns true if input is not empty' do
      expect(game_player_input.player_name_input_valid?('Player One')).to be true
    end

    it 'returns false if input is empty' do
      expect(game_player_input.player_name_input_valid?('')).to be false
    end
  end

  describe '#player_turn' do
    subject(:game_player_turn) { described_class.new }
    let(:board) { double(Board) }
    let(:player) { double(Player, name: 'Player One', color: '🔴') }

    before do
      allow(game_player_turn).to receive(:player_input).with(player).and_return(1)
      allow(board).to receive(:place_color).with(0, '🔴').and_return(true)
      allow(game_player_turn).to receive(:puts_player_input_invalid)
    end

    it 'calls Board#place_color with correct arguments' do
      game_player_turn.instance_variable_set(:@board, board)

      expect(board).to receive(:place_color).with(0, '🔴').and_return(true)

      game_player_turn.player_turn(player)
    end

    context 'when Board#place_color returns true' do
      it 'returns' do
        game_player_turn.instance_variable_set(:@board, board)

        expect(board).to receive(:place_color).with(0, '🔴').and_return(true)

        expect(game_player_turn.player_turn(player)).to be nil
      end
    end

    context 'when Board#place_color returns false' do
      it 'calls puts_player_input_invalid' do
        game_player_turn.instance_variable_set(:@board, board)

        expect(board).to receive(:place_color).with(0, '🔴').and_return(false)
        expect(game_player_turn).to receive(:puts_player_input_invalid)

        game_player_turn.player_turn(player)
      end

      it 'class Game#player_turn again (testing player_input)' do
        game_player_turn.instance_variable_set(:@board, board)

        expect(board).to receive(:place_color).with(0, '🔴').and_return(false)
        expect(game_player_turn).to receive(:player_input).with(player).twice

        game_player_turn.player_turn(player)
      end
    end
  end

  describe '#player_input' do
    subject(:game_player_input) { described_class.new }
    let(:board) { double(Board) }
    let(:player) { double(Player, name: 'Player One', color: '🔴') }

    before do
      allow(game_player_input).to receive(:puts_player_input)
      allow(game_player_input).to receive(:gets).and_return('1')
      allow(game_player_input).to receive(:player_input_valid?).and_return(true)
      allow(game_player_input).to receive(:puts_player_input_invalid)
    end

    it 'calls Game#puts_player_input with correct arguments' do
      expect(game_player_input).to receive(:puts_player_input).with(player)

      game_player_input.player_input(player)
    end

    context 'when player_input_valid? returns true' do
      it 'returns player input' do
        expect(game_player_input).to receive(:player_input_valid?).and_return(true)

        expect(game_player_input.player_input(player)).to eq(1)
      end
    end

    context 'when player_input_valid? returns false' do
      it 'calls puts_player_input_invalid' do
        expect(game_player_input).to receive(:player_input_valid?).and_return(false)
        expect(game_player_input).to receive(:puts_player_input_invalid)

        game_player_input.player_input(player)
      end
    end
  end

  describe '#player_input_valid?' do
    subject(:game_player_input) { described_class.new }
    let(:board) { double(Board) }

    it 'returns true if input is between 1 and 7' do
      expect(game_player_input.player_input_valid?(1)).to be true
    end

    it 'returns true if input is between 1 and 7 (x2)' do
      expect(game_player_input.player_input_valid?(7)).to be true
    end

    it 'returns false if input is not between 1 and 7' do
      expect(game_player_input.player_input_valid?(8)).to be false
    end

    it 'returns false if input is not between 1 and 7 (x2)' do
      expect(game_player_input.player_input_valid?(0)).to be false
    end
  end

  describe '#game_over?' do
    subject(:game_over) { described_class.new }
    let(:board) { double(Board) }
    let(:player_one) { double(Player, name: 'Player One', color: '🔴') }
    let(:player_two) { double(Player, name: 'Player Two', color:  '⚫') }

    before do
      game_over.instance_variable_set(:@board, board)
      game_over.instance_variable_set(:@player_one, player_one)
      game_over.instance_variable_set(:@player_two, player_two)
      allow(board).to receive(:full?).and_return(false)
      allow(board).to receive(:won?).and_return(false)
    end

    context 'when board is full' do
      it 'returns true' do
        allow(board).to receive(:full?).and_return(true)

        expect(game_over.game_over?).to be true
      end
    end

    context 'when board is not full' do
      context 'player one wins' do
        it 'returns true' do
          allow(board).to receive(:won?).with(player_one.color).and_return(true)
          allow(board).to receive(:won?).with(player_two.color).and_return(false)

          expect(game_over.game_over?).to be true
        end
      end

      context 'when player two wins' do
        it 'returns true' do
          allow(board).to receive(:won?).with(player_one.color).and_return(false)
          allow(board).to receive(:won?).with(player_two.color).and_return(true)

          expect(game_over.game_over?).to be true
        end
      end

      context 'when no one wins' do
        it 'returns false' do
          allow(board).to receive(:won?).with(player_one.color).and_return(false)
          allow(board).to receive(:won?).with(player_two.color).and_return(false)

          expect(game_over.game_over?).to be false
        end
      end
    end
  end

  describe '#winner' do
    subject(:board_winner) { described_class.new }
    let(:board) { double(Board) }
    let(:player_one) { double(Player, name: 'Player One', color: '🔴') }
    let(:player_two) { double(Player, name: 'Player Two', color:  '⚫') }

    before do 
      board_winner.instance_variable_set(:@board, board)
      board_winner.instance_variable_set(:@player_one, player_one)
      board_winner.instance_variable_set(:@player_two, player_two)
      allow(board).to receive(:won?).and_return(false)
    end

    context 'when player one wins' do
      it 'returns player one' do
        allow(board).to receive(:won?).with(player_one.color).and_return(true)
        allow(board).to receive(:won?).with(player_two.color).and_return(false)

        expect(board_winner.winner).to eq(player_one)
      end
    end

    context 'when player two wins' do
      it 'returns player two' do
        allow(board).to receive(:won?).with(player_one.color).and_return(false)
        allow(board).to receive(:won?).with(player_two.color).and_return(true)

        expect(board_winner.winner).to eq(player_two)
      end
    end
  end
end
