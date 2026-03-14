require 'tty-prompt'
require 'colorize'
prompt = TTY::Prompt.new
board = Array.new(3) { Array.new(3, " ") }
moves = 0

def display_board(board)
  puts
  board.each_with_index do |row, r|
    display_row = row.map do |cell|
      if cell == "X"
        cell.colorize(:red)
      elsif cell == "O"
        cell.colorize(:blue)
      else
        " "
      end
    end
    puts " #{display_row.join(" | ")} "
    puts "---+---+---" unless r == 2
  end
  puts
end

def take_choices(board)
  choices = []
  (0..2).each do |r|
    row_choices = []
    (0..2).each do |c|
      if board[r][c] == " "
        row_choices << { name: "   ", value: [r, c] }
      else
        symbol = board[r][c] == "X" ? board[r][c].colorize(:red) : board[r][c].colorize(:blue)
        row_choices << { name: " #{symbol} ", disabled: "taken" }
      end
    end
    choices << row_choices
  end
  choices
end


def check_win(board, symbol)
  return true if board.any? { |row| row.all? { |cell| cell == symbol } }
  return true if (0..2).any? { |c| board.all? { |cell| cell[c] == symbol } }
  return true if board[0][0] == symbol &&
                 board[1][1] == symbol &&
                 board[2][2] == symbol
  return true if board[0][2] == symbol &&
                 board[1][1] == symbol &&
                 board[2][0] == symbol
  false
end
puts "player 1 choose symbol (X/O):"
player1 = gets.chomp.upcase
player2 = player1 == "X" ? "O" : "X"
current_player = 1

loop do
  display_board(board)
  symbol = current_player == 1 ? player1 : player2
  colored_symbol = symbol == "X" ? symbol.colorize(:red) : symbol.colorize(:blue)
  puts "player #{current_player}'s turn"
  choices = take_choices(board)
  row, col = prompt.select("Select your cell", choices)
  board[row][col] = symbol
  moves += 1
  if moves >= 5 && check_win(board, symbol)
    display_board(board)
    puts "player #{current_player} winssss"
    break
  end
  if moves == 9
    display_board(board)
    puts "opps there is a tie"
    break
  end
  current_player = current_player == 1 ? 2 : 1
end