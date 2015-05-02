require_relative '../lib/card.rb'

describe Card do
  subject(:card) { Card.new(:heart, :ten) }
  let(:possible_suits) { [:heart, :club, :spade, :diamond] }
  let(:possible_values) { (2..14).to_a }

  it 'has a suit' do
    expect(card.suit).to_not eq(nil)
  end

  it 'has a valid suit' do
    expect(possible_suits).to include(card.suit)
  end

  it 'has a value' do
    expect(card.value).to_not eq(nil)
  end

  it 'has a valid value' do
    expect(possible_values).to include(card.value)
  end

  describe '#<=>(comparing_card)' do
    let(:bigger_card) {Card.new(:heart, :jack)}
    let(:smaller_card) {Card.new(:club, :six)}
    let(:equal_card) {Card.new(:diamond, :ten)}

    it 'returns -1 if own cards value is greater than comparing card' do
      expect(card <=> bigger_card).to eq(-1)
    end

    it 'returns 0 if own cards value is equal to comparing card' do
      expect(card <=> equal_card).to eq(0)
    end

    it 'returns 1 if own cards value is less than comparing card' do
      expect(card <=> smaller_card).to eq(1)
    end

  end

end
