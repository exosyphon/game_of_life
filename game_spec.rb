require_relative "./game"

RSpec.describe Game do
  describe "#next_generation" do
    it "kills a live cell with fewer than two live neighbours" do
      game = Game.new([[1]])

      expect(game.next_generation).to eq([[0]])
    end

    it "keeps a live cell with two live neighbours alive" do
      game = Game.new([[1, 1, 1]])

      expect(game.next_generation).to eq([[0, 1, 0]])
    end

    it "kills a live cell with more than three live neighbours" do
      game = Game.new([
        [1, 1, 1],
        [1, 1, 1],
        [1, 1, 1]
      ])

      expect(game.next_generation).to eq([
        [1, 0, 1],
        [0, 0, 0],
        [1, 0, 1]
      ])
    end

    it "brings a dead cell with exactly three live neighbours to life" do
      game = Game.new([
        [0, 1, 0],
        [0, 1, 0],
        [0, 1, 0]
      ])

      expect(game.next_generation).to eq([
        [0, 0, 0],
        [1, 1, 1],
        [0, 0, 0]
      ])
    end

    it "kills for underpopulation" do
      game = Game.new([
        [0, 1, 0],
        [0, 0, 0],
        [0, 1, 0]
      ])

      expect(game.next_generation).to eq([
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ])
    end
  end
end
