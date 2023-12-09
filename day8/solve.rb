input = File.open('input.txt', 'r')

data = input.readlines

input.close()

instructions = data[0].chomp
parsed = {}

data.map { |e| e.chomp }.drop(1).drop(1).each do |item|
  equal_split = item.split('=').map { |e| e.gsub("(", "").gsub(")", "") }.map(&:strip)
  parsed[equal_split[0]] = equal_split[1].split(',').map(&:strip)
end

### part1 start
steps = 0
go_to = "AAA"

until go_to == "ZZZ"
  instructions.each_char do |char|
    if char == 'L'
      go_to = parsed[go_to][0]
    else
      go_to = parsed[go_to][1]
    end
    steps += 1
  end
end
p steps

### part2 start
a_end = []
parsed.each do |item|
  if item[0].end_with? 'A'
    a_end << item[0]
  end
end

total_steps = []

a_end.each do |search_for|
  go_to = search_for
  steps = 0
  until go_to.end_with? 'Z'
    instructions.each_char do |char|
      if char == 'L'
        go_to = parsed[go_to][0]
      else
        go_to = parsed[go_to][1]
      end
      steps += 1
    end
  end
  total_steps << steps
end

p total_steps.inject(&:lcm)
