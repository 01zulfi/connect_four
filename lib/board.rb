# frozen_string_literal: true

# board
class Board
  attr_reader :board

  def initialize
    @board = create_board
  end

  private

  def create_board
    Array.new(6) { Array.new(7) }
  end
end
