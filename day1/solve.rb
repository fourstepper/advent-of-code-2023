input = File.open("input.txt", "r")

def numeric?(lookAhead)
  lookAhead.match?(/[[:digit:]]/)
end

arr = []
word_digits = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

input.each_line do |line|
  final_double_digit = ""
  working_line = ""

  # build line that we will actually iterate on, replacing all occurences of word_digits
  # after each character
  line.each_char do |char|
    working_line << char
    word_digits.each_with_index do |word_digit, idx|
      working_line = working_line.gsub(word_digit.to_s, (idx + 1).to_s)
    end
  end

  working_line.each_char do |char|
    if numeric?(char)
      # start with double digits based on the first numeric found
      if final_double_digit.empty?
        final_double_digit << char
      end

      # if final_double_digit is two chars already, cut last before appending new
      if final_double_digit.length > 1
        final_double_digit = final_double_digit[0...-1]
      end

      final_double_digit << char
    end
  end
  arr << final_double_digit
end

puts "result: #{arr.map(&:to_i).sum}"

input.close
