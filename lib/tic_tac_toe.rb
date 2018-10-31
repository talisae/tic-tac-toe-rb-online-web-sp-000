WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, value)
  board[index] = value
end

def position_taken?(board, index)
  board[index] == 'X' || board[index] == 'O'
end

def valid_move?(board, position)
	position.to_i - 1
	if !position_taken?(board, position) && position.between?(0,8)
		true
 	else
		false
 	end
 end

def turn(board)
   puts "Please enter 1-9:"
   num = gets.chomp
   position = input_to_index(num)
   if valid_move?(board, position)
      move(board, position, "X")
      display_board(board)
   else
     turn(board)
   end
 end

def turn_count(board)
   turns = 0
   board.each do |input|
     if input == "X" || input == "O"
     turns += 1
     end
   end
   turns
end

def current_player(board)
   turn_count(board) % 2 == 0 ? "X" : "O"
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    board[combo[0]] == board[combo[1]] &&
      board[combo[1]] == board[combo[2]] &&
      position_taken?(board, combo[0])
  end
end

def full?(board)
  board.all? { |token| token == 'X' || token == 'O' }
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  winner = nil
  WIN_COMBINATIONS.each do |combo|
    if combo.all? {|index| board[index] == "X"}
      winner = "X"
    elsif combo.all? {|index| board[index] == "O"}
      winner = "O"
    else
    end
  end
  winner
end

def play(board)
  turn_count = 0
  while turn_count < 9 && !over?(board)
    turn(board)
    turn_count += 1
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  else
  end
end
