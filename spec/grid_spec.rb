require "./lib/grid"

RSpec.describe Grid do
  describe "#drop_disc" do
    it "places the first disc in the correpsonding column at zero position" do
      game = Grid.new
      game.drop_disc(4)
      expect(game.grid[4][0].abs).to eq(1)
    end

    it "places every disc of the same column on top of the others" do
      game = Grid.new
      game.drop_disc(1)
      game.drop_disc(1)
      expect(game.grid[1][1].abs).to eq(1)
    end

    it "returns an error when when the column is already full" do
      game = Grid.new
      6.times { game.drop_disc(3) }
      expect { game.drop_disc(3) }.to raise_error(RuntimeError)
    end
  end

  describe "#print_grid" do
    it "prints the current grid on the console" do
      game = Grid.new
      7.times { game.drop_disc(rand(6)) }
      expect { game.print_grid }.to output.to_stdout
    end
  end

  describe "#won?" do
    it "returns false if no player has won" do
      game = Grid.new
      game.drop_disc(2)
      game.drop_disc(4)
      game.drop_disc(6)
      expect(game.won?).to eq(false)
    end

    it "returns true if a player has won horizontally" do
      game = Grid.new
      3.times do |i|
        game.drop_disc(i)
        game.drop_disc(i)
      end
      game.drop_disc(3)
      expect(game.won?).to eq(true)
    end

    it "returns true if a player has won vertically" do
      game = Grid.new
      3.times do
        game.drop_disc(1)
        game.drop_disc(2)
      end
      game.drop_disc(1)
      expect(game.won?).to eq(true)
    end

    it "returns true if a player has won in the right-diagonal direction" do
      game = Grid.new
      a = 2 #controls the horizontal offset of the diagonal
      game.drop_disc(a + 0)
      game.drop_disc(a + 1)
      game.drop_disc(a + 1)
      game.drop_disc(a + 3)
      game.drop_disc(a + 3)
      game.drop_disc(a + 3)
      game.drop_disc(a + 3)
      game.drop_disc(a + 4)
      game.drop_disc(a + 2)
      game.drop_disc(a + 2)
      game.drop_disc(a + 2)
      expect(game.won?).to eq(true)
    end

    it "returns true if a player has won in the left-diagonal direction" do
      game = Grid.new
      a = 4 #controls the horizontal offset of the diagonal
      game.drop_disc(a - 0)
      game.drop_disc(a - 1)
      game.drop_disc(a - 1)
      game.drop_disc(a - 3)
      game.drop_disc(a - 3)
      game.drop_disc(a - 3)
      game.drop_disc(a - 3)
      game.drop_disc(a - 4)
      game.drop_disc(a - 2)
      game.drop_disc(a - 2)
      game.drop_disc(a - 2)
      expect(game.won?).to eq(true)
    end
  end
end
