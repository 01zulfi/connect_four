# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  describe '#initialize' do
    subject(:board_init) { described_class.new }

    it 'creates a new board' do
      board = board_init.board
      expect(board).to match_array(Array.new(6) { Array.new(7) })
    end
  end
end
