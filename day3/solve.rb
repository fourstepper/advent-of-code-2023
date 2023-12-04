input = File.open('input.txt', 'r')

def numeric?(lookAhead)
  lookAhead.match?(/[[:digit:]]/)
end

def special_char?(char)
  return true if char != '.' && char.match?(/[[:punct:]]/)

  return false
end

def star?(char)
  return true if char == '*'

  return false
end

lines = []

input.each_line do |line|
  lines << line
end

input.close

numbers_matrix = []
symbols_matrix = []
gear_matrix = {}

lines.each_index do |line_idx|
  lines[line_idx].each_char.with_index do |char, char_idx|
    if special_char? char
      symbols_matrix << [line_idx, char_idx]
    end
    if star? char
      gear_matrix[[line_idx, char_idx]] = []
    end
  end
end

lines.each_index do |line_idx|
  curr_number = {}
  lines[line_idx].each_char.with_index do |char, char_idx|
    if numeric?(char) && curr_number.empty?
      curr_number = { number: char, start_x: char_idx, end_x: char_idx, y: line_idx }
    elsif numeric?(char) && !curr_number.empty?
      curr_number[:number] = curr_number[:number] + char
      curr_number[:end_x] = char_idx
    else
      if !curr_number.empty?
        numbers_matrix << curr_number
        curr_number = {}
      end
    end
  end
end

# thanks to @djetelina for his solution in Python
# https://github.com/djetelina/aoc23/blob/main/3.py#L46
part1 = []
numbers_matrix.each do |item|
  # we should look one row behind and one row forward
  symbol_rows = [item[:y] - 1, item[:y], item[:y] + 1]
  # symbol can be located in a range from our number's starting position
  # to our number's ending position
  symbol_pos = (item[:start_x] - 1..item[:end_x] + 1).to_a
  intersect = symbol_rows.product(symbol_pos)
  intersect.each do |i|
    symbol_found = false
    if symbols_matrix.include?(i)
      symbol_found = true
    end
    if gear_matrix.include?(i)
      gear_matrix[i] << item[:number]
    end
    if symbol_found
      part1 << item[:number]
    end
  end
end

puts part1.map(&:to_i).sum

part2 = []
gear_matrix.each do |key, value|
  if value.length == 2
    part2 << value[0].to_i * value[1].to_i
  end
end

puts part2.map(&:to_i).sum
