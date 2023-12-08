input = File.open('input.txt', 'r')

data = input.readlines

input.each_line do |line|
end

input.close()

instructions = data[0].chomp
parsed = {}

data.map { |e| e.chomp }.drop(1).drop(1).each do |item|
  equal_split = item.split('=').map { |e| e.gsub("(", "").gsub(")", "") }.map(&:strip)
  parsed[equal_split[0]] = equal_split[1].split(',').map(&:strip)
end

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
