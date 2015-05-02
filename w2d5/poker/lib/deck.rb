require_relative 'card.rb'

class Deck
  attr_reader :cards

  def self.build_deck
    cards = []
    Card::SUITS.each do |suit|
      Card::VALUES.keys.each do |value|
        cards << Card.new(suit, value)
      end
    end
    cards
  end

  def initialize(cards = [])
    unless cards.empty?
      @cards = cards
    else
      @cards = self.class.build_deck
    end
  end

  def deal(n)
    raise "Not enough cards!" if n > @cards.count
    dealt_cards = []
    n.times { dealt_cards << @cards.shift }
    dealt_cards
  end

  def empty?
    return true if @cards.empty?
    false
  end

  def return(returned_cards)
    @cards += returned_cards
  end

  def shuffle
    @cards.shuffle!
  end

end
