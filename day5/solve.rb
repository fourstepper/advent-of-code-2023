input = File.open('input.txt', 'r')

newline_split = input.read.split("\n\n")
input.close

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

part2 = nil
location = 0
hit = 0

seed_ranges = data['seeds'].each_slice(2).to_a.map { |item| [item[0], item[0] + item[1]] }
seed_ranges_min = seed_ranges.min[0]
seed_ranges_max = seed_ranges.max[1]

until part2
  hit = location

  data.reverse_each do |key, value|
    if key == 'seeds'
      next
    end

    value.each_slice(3).each do |i|
      if hit.between?(i[0], i[0] + i[2])
        hit += i[1] - i[0]
        break
      end
    end
  end

  if hit > seed_ranges_min || hit < seed_ranges_max
    seed_ranges.each do |range|
      if hit.between?(range[0], range[1])
        part2 = location
      end
    end
  end
  location += 1
end

p part2
