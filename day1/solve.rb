input = File.open("input.txt", "r")

def numeric?(lookAhead)
  lookAhead.match?(/[[:digit:]]/)
end

arr = []

input.each_line do |line|
  line_digit = ""
  line.each_char do |char|
    if numeric?(char)
      # start with double digits based on the first numeric found
      if line_digit.length == 0
        line_digit << char
      end

      # if line_digit is two chars already, cut last before appending new
      if line_digit.length == 2
        line_digit = line_digit[0...-1]
      end
      line_digit << char
    end
  end
  arr << line_digit
end

puts arr.map(&:to_i).sum
