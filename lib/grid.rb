class Grid
  attr_accessor :grid

  def initialize
    @current_player = 1
    @grid = Array.new(7, 0)
    @grid.map! { |col| col = Array.new(6, 0)}
  end

  def play
    @current_player = 1
    max_moves = 6 * 7
    moves_count = 0
    while !won? && moves_count < max_moves
      print_grid
      puts "Write the column number you want to drop the disc in"
      drop_disc(gets.chomp.to_i - 1)
      moves_count += 1
    end
    print_grid
    if moves_count === max_moves
      puts "Draw!"
    else
      puts "You won!"
    end
  end

  # Drops a disc in the correpsonding column in the first empty space
  def drop_disc(col)
    for i in 0..5
      if @grid[col][i] === 0
        @grid[col][i] = @current_player
        @current_player = -@current_player
        return
      end
    end
    raise "Error: column already full"
  end

  # Checks if a player has won and returns true or false
  def won?
    #Horizontal check
    5.times do |row_index|
      4.times do |i|
        sum = 0
        4.times { |j| sum += @grid[i + j][row_index] }
        if sum.abs === 4
          return true
        end
      end
    end

    #Vertical check
    @grid.each do |col|
      3.times do |i|
        if col[i..i+4].sum.abs === 4
          return true
        end
      end
    end

    #Diagonal check
    3.times do |row|
      4.times do |col|
        sum1 = 0
        sum2 = 0
        4.times do |j|
          sum1 += @grid[col + j][row + j]      #Right direction
          sum2 += @grid[6 - col - j][row + j]  #Left direction
        end
        if sum1.abs === 4 || sum2.abs === 4
          return true
        end
      end
    end

    return false
  end

  def print_grid
    5.downto(0).each do |row_index|
      temp = []
      @grid.each do |col|
        if col[row_index] === 1
          temp << "X"
        elsif col[row_index] === -1
          temp << "O"
        else
          temp << " "
        end
      end
      puts "|" + temp.join("|") + "|"
    end
    puts " " + (1..7).to_a.join(" ")
  end
end
