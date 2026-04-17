require_relative "./game"

class GameRunner
  def initialize(board:, io: $stdout, printer: BoardPrinter, sleeper: Kernel)
    @board = board
    @io = io
    @printer = printer
    @sleeper = sleeper
  end

  def run(generations:, delay:)
    current_board = @board

    generations.times do |generation|
      @io.print("\e[H\e[2J")
      @printer.print(current_board, io: @io)

      next if generation == generations - 1

      @sleeper.sleep(delay)
      current_board = Game.new(current_board).next_generation
    end
  end
end

module RunnerScript
  DEFAULT_BOARD = [
    [0, 1, 0],
    [0, 1, 0],
    [0, 1, 0]
  ].freeze

  module_function

  def run(argv, io: $stdout, sleeper: Kernel, printer: BoardPrinter)
    runner = GameRunner.new(
      board: DEFAULT_BOARD,
      io: io,
      printer: printer,
      sleeper: sleeper
    )

    runner.run(
      generations: Integer(argv.fetch(0, 10)),
      delay: Float(argv.fetch(1, 0.2))
    )
  end
end

RunnerScript.run(ARGV) if $PROGRAM_NAME == __FILE__
