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

p pipe.size / 2
