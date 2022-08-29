# frozen_string_literal: true

require_relative '../lib/display'
require_relative '../lib/board'
require_relative '../lib/player'

# game loop class
class Game
  attr_reader :board, :player_one, :player_two

  include Display

  def initialize
    @board = Board.new
  end

  def play
    puts_introduction
    player_initialization
    play_round until game_over?
    display_board
    announce_result
    restart
  end

  def announce_result
    return puts_draw if draw?

    puts_winner(winner)
  end

  def draw?
    board.full?
  end

  def player_initialization
    player_one_name = player_name_input('Player One')
    player_two_name = player_name_input('Player Two')

    @player_one = Player.new(player_one_name, '🔴')
    @player_two = Player.new(player_two_name, '⚫')
  end

  def player_name_input(player_signature)
    puts_enter_player_name(player_signature)
    loop do
      name = gets.chomp
      return name if player_name_input_valid?(name)

      puts_player_name_input_invalid
    end
  end

  def player_name_input_valid?(input)
    !input.empty?
  end

  def play_round
    display_board
    player_turn(player_one)
    display_board
    return if game_over?

    player_turn(player_two)
  end

  def player_turn(player)
    column = player_input(player)
    is_placed = board.place_color(column - 1, player.color)

    return if is_placed

    puts_player_input_invalid
    player_turn(player)
  end

  def player_input(player)
    puts_player_input(player)
    loop do
      input = gets.chomp.to_i
      return input if player_input_valid?(input)

      puts_player_input_invalid
    end
  end

  def player_input_valid?(input)
    input.between?(1, 7)
  end

  def game_over?
    @board.full? || @board.won?(player_one.color) || @board.won?(player_two.color)
  end

  def winner
    board.won?(player_one.color) ? player_one : player_two
  end

  def display_board
    puts_board(@board.board)
  end
end
