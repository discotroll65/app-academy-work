require_relative "../lib/hanoi.rb"
describe Hanoi do
  subject(:game) { Hanoi.new }

  it 'starts with 3 towers' do
    expect(game.towers).to be_a(Array)
    expect(game.towers.size).to eq(3)
  end

  it 'starts with discs only in the first tower by default' do
    other_towers_empty = game.towers[1..-1].all? { |el| el.empty? }

    expect(other_towers_empty).to eq(true)
  end

  describe '#render_towers' do
    subject(:game) { Hanoi.new }

    it 'makes the 0 index the top of the tower' do
      game.instance_variable_set(:@towers, [
        [2, 1],
        [6, 3],
        [5, 4]
        ])

      expect(game.render_towers).to eq("134\n265")
    end

    context 'when tower is empty' do
      it 'displays an underscore in the empty tower' do
        game.instance_variable_set(:@towers, [
          [2, 1],
          [],
          [5, 4]
          ])

        expect(game.render_towers).to eq("1 4\n2_5")
      end
    end
  end

  describe '#move(start_tower, end_tower)' do

    it 'moves disk to top of end tower if top disk from start is smaller' do
      game.instance_variable_set(:@towers,
      [
        [3, 2, 1],
        [],
        [],
      ]  )
      game.move([1,2])

      expect(game.towers).to eq([
          [3, 2],
          [1],
          []
          ])
    end

    context 'when trying to move disc' do
      it 'Will not move bigger start disc on top of a smaller end disc' do
        game.instance_variable_set(:@towers, [
          [],
          [1],
          [3, 2]
          ])

        expect{ game.move([3, 2])}.to raise_error("Illegal Move")
      end

      it 'Will not let you move from an empty tower' do
        game.instance_variable_set(:@towers, [
          [],
          [1],
          [3, 2]
          ])

        expect {game.move([1,2])}.to raise_error("Illegal Move")
      end
    end
  end

  describe '#won?' do

    context 'when actually won' do
      let(:game1) { Hanoi.new }
      let(:game2) { Hanoi.new}
      before (:each) do
        game1.instance_variable_set(:@towers, [
          [],
          [],
          [3, 2, 1]
          ])

        game2.instance_variable_set(:@towers, [
          [],
          [3, 2, 1],
          []
          ])
      end

      it 'returns true when all discs are in any tower except the first' do
        expect(game1.won?).to eq(true)
        expect(game2.won?).to eq(true)
      end
    end

    context 'when not actually won' do
      subject(:game) {Hanoi.new}

        it 'returns false when the initial tower is complete' do
          game.instance_variable_set(:@towers, [
            [3, 2, 1],
            [],
            []
            ] )

          expect(game.won?).to eq(false)
        end
      end
  end

end
