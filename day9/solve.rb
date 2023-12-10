input = File.open('input.txt', 'r')

data = input.readlines.map(&:chomp).map { |e| e.split(' ') }.map { |e| e.map(&:to_i) }

input.close()

def p1(arr)
  if arr.all?(0)
    return 0
  end

  to_append = []
  arr.each_with_index do |d, i|
    if i == 0
      next
    end

    to_append << arr[i] - arr[i - 1]
  end
  return arr[-1] + p1(to_append)
end

def p2(arr)
  if arr.all?(0)
    return 0
  end

  to_append = []
  arr.each_with_index do |d, i|
    unless i == arr.length - 1
      to_append << arr[i + 1] - arr[i]
    end
  end

  return arr[0] - p2(to_append)
end

p data.map { |e| p1(e) }.sum
p data.map { |e| p2(e) }.sum
