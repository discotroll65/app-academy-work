require_relative '../lib/array.rb'

describe Array do
  describe '#my_uniq' do
    subject(:array) { [1, 2, 1, 3, 3] }

    it 'removes duplicates' do
      expect(array.my_uniq).to eq([1, 2, 3])
    end

    it 'returns unique elements in their original order' do
      expect(array.my_uniq).to_not eq([3, 2, 1])
    end

  end
end
