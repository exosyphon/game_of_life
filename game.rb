class Game
  def initialize(board)
    @board = board
  end

  def next_generation
    @board.each_with_index.map do |row, row_index|
      row.each_with_index.map do |cell, column_index|
        next_cell_state(cell, row_index, column_index)
      end
    end
  end

  private

  def next_cell_state(cell, row_index, column_index)
    live_neighbour_count = live_neighbours(row_index, column_index)

    return 1 if cell.zero? && live_neighbour_count == 3
    return 0 if cell == 1 && (live_neighbour_count < 2 || live_neighbour_count > 3)

    cell
  end

  def live_neighbours(row_index, column_index)
    neighbours(row_index, column_index).count(1)
  end

  def neighbours(row_index, column_index)
    (-1..1).flat_map do |row_offset|
      (-1..1).map do |column_offset|
        next if row_offset.zero? && column_offset.zero?

        cell_at(row_index + row_offset, column_index + column_offset)
      end
    end.compact
  end

  def cell_at(row_index, column_index)
    return unless row_index.between?(0, @board.length - 1)
    return unless column_index.between?(0, @board.first.length - 1)

    @board[row_index][column_index]
  end
end

class BoardPrinter
  LIVE_CELL = "O"
  DEAD_CELL = "."

  def self.format(board)
    board.map do |row|
      row.map { |cell| cell.zero? ? DEAD_CELL : LIVE_CELL }.join(" ")
    end.join("\n")
  end

  def self.print(board, io: $stdout)
    io.puts(format(board))
  end
end
