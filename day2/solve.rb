input = File.open("input.txt", "r")

def parse_line(line)
  result = {
    game_number: "",
    shows: []
  }
  result[:game_number] = line.split(":")[0].split(" ")[1]
  shows = line.split(":")[1].strip.split(";")

  shows.each do |show|
    add = {}
    colors = show.strip.split(",")
    colors.each do |color|
      amount = color.strip.split[0]
      color_name = color.strip.split[1]
      add[color_name] = amount
    end
    result[:shows] << add
  end
  return result
end

loaded = []
input.each_line do |line|
  loaded << parse_line(line)
end

input.close

max = { red: 12, green: 13, blue: 14 }

part1 = []
loaded.each do |game|
  add = true
  game[:shows].each do |show|
    show.each do |key, value|
      if value.to_i > max[key.to_sym].to_i
        add = false
      end
    end
  end
  if add
    part1 << game[:game_number].to_i
  end
end

puts part1.sum

part2 = []
loaded.each do |game|
  max = { red: 0, green: 0, blue: 0 }
  game[:shows].each do |show|
    show.each do |key, value|
      if value.to_i > max[key.to_sym].to_i
        max[key.to_sym] = value.to_i
      end
    end
  end
  part2 << max.values.inject(:*)
end

puts part2.sum
