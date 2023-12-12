input = File.open('input.txt', 'r')

data = input.readlines.map(&:chomp)

input.close()

def row_expand(data)
  empty_rows = []
  data.each_with_index do |row, idx|
    if row.chars.all?('.')
      empty_rows << idx
    end
  end

  return empty_rows
end

def col_expand(data)
  columns =  data.length
  row_length = data.first.length

  empty_columns = []
  0.upto(row_length - 1) do |cell|
    temp = []
    0.upto(columns - 1) do |row|
      temp << data[row][cell]
    end
    if temp.all?('.')
      empty_columns << cell
    end
  end

  return empty_columns
end

extra_rows = row_expand(data)
extra_cols = col_expand(data)

def path_lengths(stars, extra_rows, extra_cols, factor)
  first, second = stars
  d = (first[0] - second[0]).abs + (first[1] - second[1]).abs

  # min and max of x between the two stars
  x_min, x_max = [first[0], second[0]].minmax
  # min and max of y between the two stars
  y_min, y_max = [first[1], second[1]].minmax

  # iterate over rows and cols, d += factor - 1 if we hit an empty row or column
  (x_min..x_max).each do |x|
    if extra_rows.include?(x)
      d += factor - 1
    end
  end
  (y_min..y_max).each do |y|
    if extra_cols.include?(y)
      d += factor - 1
    end
  end

  return d
end

pos = []
data.each_with_index do |row, x|
  row.chars.each_with_index do |cell, y|
    if cell == '#'
      pos << [x, y]
    end
  end
end

p pos.combination(2).to_a.map { |pair| path_lengths(pair, extra_rows, extra_cols,  2) }.sum
p pos.combination(2).to_a.map { |pair| path_lengths(pair, extra_rows, extra_cols,  1000000) }.sum
