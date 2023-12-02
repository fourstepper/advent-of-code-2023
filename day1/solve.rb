input = File.open("input.txt", "r")

def numeric?(lookAhead)
  lookAhead.match?(/[[:digit:]]/)
end

arr = []

mapping = {
  'one' => '1',
  'two' => '2',
  'three' => '3',
  'four' => '4',
  'five' => '5',
  'six' => '6',
  'seven' => '7',
  'eight' => '8',
  'nine' => '9',
}

input.each_line do |line|
  ## swap reggied based on if you want part 1 or part 2 solution
  # reggied = line.scan(/(?=(\d))/).flatten
  reggied = line.scan(/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/).flatten
  mapped = []

  reggied.each do |reggie|
    if mapping.include? reggie
      mapped << mapping[reggie]
    else
      mapped << reggie
    end
  end

  arr << "#{mapped[0]}#{mapped[-1]}"
end

input.close

puts arr.map(&:to_i).sum
