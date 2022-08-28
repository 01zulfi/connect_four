# frozen_string_literal: true

require 'pry-byebug'

# board
class Board
  attr_reader :board

  def initialize(board = create_board)
    @board = board
  end

  def place_color(column, color)
    return false unless valid_column?(column)

    row = last_empty_row(column)

    return false if row.nil?

    board[row][column] = color
    true
  end

  def horizontal_win?(color)
    won = false
    board.each do |row|
      won = true if row.each_cons(4).any? { |fours| same_color?(fours, color) }
    end
    won
  end

  def vertical_win?(color)
    won = false
    board.transpose.each do |row|
      won = true if row.each_cons(4).any? { |fours| same_color?(fours, color) }
    end
    won
  end

  private

  def same_color?(array, color)
    array.all? { |e| e == color }
  end

  def valid_column?(column)
    return false unless column.instance_of?(Integer)

    (0..6).cover?(column)
  end

  def last_empty_row(column)
    row_index = nil
    board.each_with_index do |row, index|
      row_index = index if row[column].nil?
    end

    row_index
  end

  def create_board
    Array.new(6) { Array.new(7) }
  end
end
