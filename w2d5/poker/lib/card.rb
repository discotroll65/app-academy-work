class Card

  SUITS = [:heart, :club, :spade, :diamond]

  VALUES = {
    deuce: 2,
    three: 3,
    four: 4,
    five: 5,
    six: 6,
    seven: 7,
    eight: 8,
    nine: 9,
    ten: 10,
    jack: 11,
    queen: 12,
    king: 13,
    ace: 14
  }

  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = VALUES[value]
  end

  def <=>(comparing_card)
    case value <=> comparing_card.value
    when 1
      1
    when 0
      0
    when -1
      -1
    end
  end

end
