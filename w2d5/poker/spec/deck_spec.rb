require_relative '../lib/deck.rb'
require 'pry'

describe Deck do
  subject(:deck) { Deck.new }

  it 'is made of cards' do
    made_of_cards = deck.cards.all?{|card| card.is_a?(Card)}

    expect(made_of_cards).to be true
  end

  it 'starts with 52 cards' do
    expect(deck.cards.count).to eq(52)
  end

  describe '#deal(n)' do
    let(:deck) do Deck.new([
        Card.new(:heart, :nine),
        Card.new(:heart, :ten),
        Card.new(:heart, :six),
        Card.new(:diamond, :eight),
        Card.new(:spade, :jack)
      ])
    end

    let!(:cards) { deck.deal(2) }

    # before(:each) do
    #   deck.instance_variable_set(:@cards, [
    #   ])
    # end

    it 'does not let the dealer deal more than they have' do
      expect {deck.deal(53)}.to raise_error("Not enough cards!")
    end

    it 'returns an array of n cards from top of deck' do
      expect(cards[0].value).to eq(9)
      expect(cards[0].suit).to eq(:heart)
      expect(cards[1].value).to eq(10)
      expect(cards[1].suit).to eq(:heart)
    end

    it 'removes the dealt cards from the deck' do
      expect(deck.cards.count).to eq(3)
      expect(deck.cards).to_not include(cards[0])
      expect(deck.cards).to_not include(cards[1])
    end

  end

  describe '#empty?' do
    it 'returns false if the deck is not empty' do
      expect(deck.empty?).to be false
    end

    it 'returns true if the deck is empty' do
      deck.instance_variable_set(:@cards, [])
      expect(deck.empty?).to be true
    end
  end

  describe '#return' do
    it 'adds cards into deck' do
      deck.instance_variable_set(:@cards, [
        Card.new(:heart, :deuce),
        Card.new(:heart, :three),
        Card.new(:heart, :six),
        Card.new(:diamond, :eight),
        Card.new(:spade, :jack)
        ])
      cards = [Card.new(:club, :seven), Card.new(:heart, :queen)]
      deck.return(cards)

      expect(deck.cards.count).to eq(7)
      expect(deck.cards).to include(cards[0])
      expect(deck.cards).to include(cards[1])
    end
  end

  describe '#shuffle' do
    it 'shuffles the deck' do
      card1 = deck.cards[0]
      card2 = deck.cards[9]
      deck.shuffle

      expect(deck.cards.count).to eq(52)
      expect(deck.cards[0]).to_not be(card1)
      expect(deck.cards[9]).to_not be(card2)
    end
  end

end
