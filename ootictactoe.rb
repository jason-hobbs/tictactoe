class Board
  attr_accessor :board, :human, :com
  def initialize
    @board = {1 => ' ', 2 => ' ', 3 => ' ', 4 => ' ', 5 => ' ', 6 => ' ', 7 => ' ', 8 => ' ', 9 => ' '}
    @human = human
    @com = com
  end

  def draw_board
    system 'clear'
    puts ""
    puts "  #{board[1]}  |  #{board[2]}  |  #{board[3]}  "
    puts "-----+-----+-----"
    puts "  #{board[4]}  |  #{board[5]}  |  #{board[6]}  "
    puts "-----+-----+-----"
    puts "  #{board[7]}  |  #{board[8]}  |  #{board[9]}  "
  end

  def empty_positions
    board.select {|k, v| v == ' ' }.keys
  end

  def human_mark(pos)
    @board[pos] = 'X'
  end

  def computer_mark
    pos = empty_positions.sample
    if @board[5] == ' '
      @board[5] = 'O'
    else
      @board[pos] = 'O'
    end
  end

  def check_board_for_winner
    winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    winning_lines.each do |line|
      if @board[line[0]] == 'O' && @board[line[1]] == 'O' && @board[line[2]] == 'O'
        return 'Computer'
      end
      if @board[line[0]] == 'X' && @board[line[1]] == 'X' && @board[line[2]] == 'X'
        return 'Player'
      end
    end
    return nil
  end
end

class Player
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def to_s
    puts "Hello #{name}"
  end
end

class Game
  def initialize
    @board = Board.new
  end

  def human_pick(p)
    open = @board.empty_positions
    puts "#{p.name}, Pick a position #{open}"
    pos = gets.chomp.to_i
    @board.human_mark(pos)
  end

  def play
    @board.draw_board
    puts "What is your name?"
    name = gets.chomp
    player = Player.new(name)
    begin
      human_pick(player)
      @board.draw_board
      winner = @board.check_board_for_winner
      @board.computer_mark
      @board.draw_board
      winner = @board.check_board_for_winner
    end until winner || @board.empty_positions.empty?
    if winner
      puts "#{winner} won!"
    else
      puts "game ended in a tie"
    end
  end
end

game = Game.new.play
