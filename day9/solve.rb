input = File.open('input.txt', 'r')

data = input.readlines.map(&:chomp).map { |e| e.split(' ') }.map { |e| e.map(&:to_i) }

input.close()

sequences = {}
data.each_index do |idx|
  sequences[idx] = []
  sequences[idx] << data[idx]
end

sequences.each_value do |v|
  idx = 0
  until v[-1].uniq.count == 1 && v[-1][0] == 0 do
    to_append = []
    v[idx].each_with_index do |d, i|
      if i == 0
        next
      end

      to_append << v[idx][i] - v[idx][i - 1]
    end

    v << to_append
    idx += 1
  end
end

p1 = []
sequences.each_value do |s|
  to_append = 0
  s.each do |i|
    to_append += i[-1]
  end
  p1 << to_append
end

p p1.sum
