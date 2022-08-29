# frozen_string_literal: true

# for display methods
module Display
  def puts_board(board)
    system('clear')
    board.push([' 1', ' 2', ' 3', ' 4', ' 5', ' 6', '7'])
    board.each do |row|
      row = row.map { |cell| cell.nil? ? '⚪' : cell }
      puts '-' * 33
      puts row.join(' | ')
    end
    board.pop
  end

  def puts_introduction
    system('clear')
    puts <<-INTRODUCTION
Connect Four!

First player to connect four consecutive markers (either vertically, horizontally, or diagonally) wins the game.
    INTRODUCTION
    puts ''
  end

  def puts_enter_player_name(player_signature)
    puts "#{player_signature}, enter name:"
  end

  def puts_player_name_input_invalid
    puts 'Invalid name, enter again: '
  end

  def puts_player_input(player)
    puts "#{player.name} #{player.color}, make your move! [1,7]"
  end

  def puts_player_input_invalid
    puts 'Invalid input.'
  end

  def puts_draw
    puts 'Game drawn'
  end

  def puts_winner(winner)
    puts "#{winner.name} #{winner.color} won"
  end
end
