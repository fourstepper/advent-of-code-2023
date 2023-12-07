PART2 = true
ORDER = PART2 ? "J23456789TQKA" : "23456789TJQKA"

input = File.open('input.txt', 'r')

data = input.readlines

input.close()

class Hand
  include Comparable
  attr_reader :name, :cards, :bid

  def self.parse(line)
    c, b = line.split
    bid = b.to_i
    cards = c.chars.map do |char|
      ORDER.index(char) + 2 # we start at two
    end
    new(cards, c, bid)
  end

  def initialize(cards, name, bid)
    @name = name
    @cards = cards
    @bid = bid
  end

  def <=>(other)
    [type, cards] <=> [other.type, other.cards]
  end

  def type
    card_counts = cards.tally
    if PART2
      jokers = cards.count(2) # J "maps" to integer 2
      card_counts.delete(2)
    else
      jokers = 0
    end

    # the decimal-pointed numbers explained really well here https://youtu.be/bASPI9cV7R4?si=8WBMdf8JVHsVYer0&t=1239
    # basically, a single joker for two of a kind makes it three of a kind (directly up a one)
    # however, adding a joker to two pairs makes it a full house - higher than a three of a pair
    if card_counts.values.any?(5)
      5
    elsif card_counts.values.any?(4)
      4 + jokers
    elsif card_counts.values.any?(3) && card_counts.values.any?(2)
      3.5 + jokers
    elsif card_counts.values.any?(3)
      3 + jokers
    elsif card_counts.values.count(2).equal?(2)
      2.5 + jokers
    elsif card_counts.values.any?(2)
      2 + jokers
    else
      # take minimum value (protects against 5 + 1 jokers)
      [1 + jokers, 5].min
    end
  end
end

hands = data.map do |line|
  Hand.parse(line)
end

sorted_hands = hands.sort

result = 0
sorted_hands.each_with_index do |h, i|
  result += h.bid * (i + 1)
end

p result
