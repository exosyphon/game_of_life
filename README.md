## Conways Game of Life

https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

Rules:
1. Any live cell with fewer than two live neighbours dies, as if by underpopulation.
2. Any live cell with two or three live neighbours lives on to the next generation.
3. Any live cell with more than three live neighbours dies, as if by overpopulation.
4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

## Setup

Install gems:

```bash
bundle install
```

## Run The Tests

Run the full test suite:

```bash
bundle exec rspec
```

Run only the game rules specs:

```bash
bundle exec rspec spec/game_spec.rb
```

Run only the runner specs:

```bash
bundle exec rspec spec/runner_spec.rb
```

## Run The Terminal Animation

Run the animated runner with explicit generations and delay in seconds:

```bash
ruby runner.rb 10 0.2
```

Run with defaults (`10` generations, `0.2` second delay):

```bash
ruby runner.rb
```

## Output Format

- `O` means a live cell
- `.` means a dead cell
- the runner clears and redraws the terminal between generations

Example board output:

```text
. O .
. O .
. O .
```

Example two-generation run (`ruby runner.rb 2 0`):

```text
. O .
. O .
. O .

. . .
O O O
. . .
```
