ORDER = "23456789TJQKA"

input = File.open('input.txt', 'r')

def parse_hand(hand)
  return hand.chars.tally.sort_by { |k, v| v }.reverse
end

def sort_hands(hand)
  parsed_hand = parse_hand(hand)

  if parsed_hand[0][1] == 5
    sorting_score = 7
  elsif parsed_hand[0][1] == 4
    sorting_score = 6
  elsif parsed_hand[0][1] == 3
    if parsed_hand[1][1] == 2
      sorting_score = 5
    else
      sorting_score = 4
    end
  elsif parsed_hand[0][1] == 2
    if parsed_hand[1][1] == 2
      sorting_score = 3
    else
      sorting_score = 2
    end
  elsif parsed_hand[0][1] == 1
    sorting_score = 1
  end

  return sorting_score, ORDER.index(hand[0][0]), ORDER.index(hand[1][0]),
    ORDER.index(hand[2][0]), ORDER.index(hand[3][0]), ORDER.index(hand[4][0])
end

data = {}
hands = []
input.each do |line|
  hand = line.split[0]
  bid = line.split[1].to_i

  data[hand] = bid
  hands << hand
end

input.close

sorted_hands = hands.sort_by { |hand| sort_hands(hand) }

result = 0
rank = 1
sorted_hands.each do |hand|
  result += data[hand] * rank
  rank += 1
end

p result
