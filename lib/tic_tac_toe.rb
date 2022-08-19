require 'pry'
WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [6,4,2]]

def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts "-----------"
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts "-----------"
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(index)
    number = index.to_i
    return number - 1
  end
  
def move(board, pos, character)
board[pos] = character
end

def valid_move?(board, index)
    if (position_taken?(board, index) == false) && (index.between?(0,8))
        true
    elsif (position_taken?(board, index) == true) && (index.between?(0,8) == false)
        false
    end
end

def position_taken?(board, index)
    if (board[index] == " ") || (board[index] == "") || (board[index] == nil)
        false
    elsif (board[index] == "X") || (board[index] == "O")
        true
    end
end

def turn_count(board)
    counter = 0
    board.each do |space|
       if space == "X" || space == "O"
        counter += 1
       end
    end
    return counter
end

def current_player(board)
    turn_count(board).even? ? "X" : "O"
end

#May need to revise
def turn(board)
    puts "Please enter 1-9:"
    input = gets.strip
    number = input_to_index(input)
    until valid_move?(board, number) == true
        puts "invalid"
        input = gets.strip
        number = input_to_index(input)
    end
    move(board, number, current_player(board))
    display_board(board)
end

def won?(board)
    winner = nil
    WIN_COMBINATIONS.each do |combo|
      if board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]] && position_taken?(board, combo[0]) == true
        winner = combo
      end
    end
    return winner.nil? ? false : winner
end


def full?(board)
    total = 0
    board.each do |spot|
      if spot == "X" || spot == "O"
        total += 1
      end
    end
    return total == 9 ? true : false
end


def draw?(board)
    won?(board) == false && full?(board) == true ? true : false
end
  
def over?(board)
    if draw?(board) == true || (won?(board) != false && full?(board) == true) || (won?(board) != false && full?(board) == false)
      return true
    else
      return false
    end
end
  
def winner(board)
    if won?(board) != false
      return board[won?(board)[0]]
    else
      return nil
    end
end

def play(board)
    until over?(board) == true
        turn(board)
    end

    if won?(board) != false
        puts "Congratulations #{winner(board)}!"
    else
        puts "Cat's Game!"
    end
end