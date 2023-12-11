require 'set'

input = File.open('input.txt', 'r')

data = input.readlines.map(&:chomp)

input.close()

grid = data.map(&:chars)

start = nil
grid.each_with_index do |row, x|
  row.each_with_index do |cell, y|
    if cell == 'S'
      start = [x, y]
    end
  end
end

DIRS = {
  "L" => [[-1, 0], [0, 1]],
  "J" => [[-1, 0], [0, -1]],
  "7" => [[0, -1], [1, 0]],
  "F" => [[0, 1], [1, 0]],
  "|" => [[-1, 0], [1, 0]],
  "-" => [[0, -1], [0, 1]],
  "." => [],
  "S" => [],
}

def neighbors(grid, point)
  x, y = point
  pipe = grid[x][y]
  DIRS[pipe].map do |dx, dy|
    [x + dx, y + dy]
  end
end

start_exits = []

[[-1, 0], [1, 0], [0, -1], [0, 1]].each do |dx, dy|
  s_neighbor = [start[0] + dx, start[1] + dy]
  if neighbors(grid, s_neighbor).include?(start)
    start_exits << s_neighbor
  end
end

start_point = start_exits.first
pipe = [start, start_point].to_set

while start_point != start_exits.last
  neighbors(grid, start_point).each do |neighbor|
    if !pipe.include?(neighbor)
      pipe << neighbor
      start_point = neighbor
    end
  end
end

puts "Part 1: #{pipe.size / 2}"

clean_grid = Array.new(grid.size) { Array.new(grid.first.size, ' ') }

pipe.each do |x, y|
  clean_grid[x][y] = grid[x][y]
end

inside = 0
inside_cells = []
# explanation of the algorithm: https://youtu.be/017epvQWPtc?si=8lD6ajSZcOp9bAo4&t=1055
clean_grid.each_with_index do |row, x|
  row.each_with_index do |cell, y|
    # Skips cells that are part of the pipeline
    next if pipe.include?([x, y])

    north = 0
    south = 0
    (y...row.size).each do |y2|
      # Count north and south facing blockers
      if ["J", "L", "|"].include?(clean_grid[x][y2])
        north += 1
      end
      # found the S in my input and manually checked where it fits
      if ["F", "7", "|", "S"].include?(clean_grid[x][y2])
        south += 1
      end
    end
    if [north, south].min.odd?
      inside += 1
      inside_cells << [x, y]
    end
  end
end

puts "Part 2: #{inside}"
