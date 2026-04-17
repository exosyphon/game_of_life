require "stringio"
require_relative "../game"
require_relative "../runner"

RSpec.describe GameRunner do
  describe "#run" do
    it "prints the initial board" do
      output = StringIO.new
      runner = described_class.new(board: [[1, 0]], io: output)

      runner.run(generations: 1, delay: 0)

      expect(output.string).to eq("\e[H\e[2JO .\n")
    end

    it "advances and prints each generation" do
      output = StringIO.new
      sleeper = instance_double("Sleeper")
      runner = described_class.new(
        board: [
          [0, 1, 0],
          [0, 1, 0],
          [0, 1, 0]
        ],
        io: output,
        sleeper: sleeper
      )

      expect(sleeper).to receive(:sleep).with(0.1).once

      runner.run(generations: 2, delay: 0.1)

      expect(output.string).to eq(
        "\e[H\e[2J. O .\n. O .\n. O .\n" \
        "\e[H\e[2J. . .\nO O O\n. . .\n"
      )
    end
  end
end

RSpec.describe RunnerScript do
  describe ".run" do
    it "starts an animation with parsed arguments" do
      output = StringIO.new
      sleeper = instance_double("Sleeper")
      runner = instance_double(GameRunner)

      expect(GameRunner).to receive(:new).with(
        board: [
          [0, 1, 0],
          [0, 1, 0],
          [0, 1, 0]
        ],
        io: output,
        printer: BoardPrinter,
        sleeper: sleeper
      ).and_return(runner)
      expect(runner).to receive(:run).with(generations: 2, delay: 0.0)

      described_class.run(%w[2 0], io: output, sleeper: sleeper)
    end
  end
end
