input = File.open('input.txt', 'r')

newline_split = input.read.split("\n\n")

data = {}

newline_split.each do |item|
  splits = item.split(':')
  data[splits[0].gsub(' map', '')] = splits[1].scan(/\d+/).map(&:to_i)
end

part1 = nil
data['seeds'].each do |seed|
  location = seed
  data.each do |key, value|
    if key == 'seeds'
      next
    end

    value.each_slice(3).to_a.each do |i|
      if location.between?(i[1], i[1] + i[2])
        location += i[0] - i[1]
        break
      end
    end
  end

  if !part1 || location < part1
    part1 = location
  end
end

p part1

input.close
