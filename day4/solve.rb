input = File.open('input.txt', 'r')

cards = {}
input.each_line do |line|
  number = line.split(':')[0].split(' ')[1]
  cards[number] = {}
  cards[number]['winning'] = line.split(':')[1].split('|')[0].chomp.split(' ').map(&:to_i)
  cards[number]['received'] = line.split(':')[1].split('|')[1].chomp.split(' ').map(&:to_i)
  cards[number]['count'] = 1
end

part1 = []
cards.each_value do |value|
  times_matched = (value['winning'] & value['received']).length
  total = 0
  if times_matched == 1
    part1 << 1
  elsif times_matched > 1
    total = 1
    times_matched.times do |i|
      if i > 0
        total *= 2
      end
    end
    part1 << total
  else
    part1 << total
  end
end

p part1.sum

part2 = []
cards.each do |key, value|
  times_matched = (value['winning'] & value['received']).length

  1.upto(times_matched) do |i|
    cards[(key.to_i + i).to_s]['count'] += cards[key]['count']
  end
end

cards.each_value do |i|
  part2 << i['count']
end

p part2.sum
