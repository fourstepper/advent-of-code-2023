input = File.open('input.txt', 'r')

data = Hash.new

input.each do |line|
  data[line.split(':')[0]] = line.split(':')[1].scan(/\d+/).map(&:to_i)
end

input.close

zipped = data["Time"].zip(data["Distance"])

part1 = []
zipped.each do |item|
  wins = []
  1.upto(item[0]) do |idx|
    remaining = (item[0] - idx)
    speed = idx

    if (remaining * speed) > item[1]
      wins << idx
    end
  end
  part1 << wins.length
end

p part1.inject(:*)

part2 = []
time = ""
distance = ""
zipped.each do |item|
  time << item[0].to_s
  distance << item[1].to_s
end

time = time.to_i
distance = distance.to_i

1.upto(time) do |idx|
  remaining = (time - idx)
  speed = idx

  if (remaining * speed) > distance
    part2 << idx
  end
end

p part2.length
