
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

  describe '#two_sum' do
    subject(:array) { [-1, 0, 2, -2, 1] }

    it 'finds indices of elements that sum to zero' do
      expect(array.two_sum).to eq([[0,4], [2,3]])
    end

    it 'returns the earlier index first' do
      expect(array.two_sum).to_not include([4,0])
    end

    it 'sorts the pairs chronologically' do
      expect(array.two_sum).to_not eq([[2,3], [0,4]])
    end
  end

  describe '#my_transpose' do
    subject(:matrix) { [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8]
    ] }

    it 'switches rows and colums' do
      expect(matrix.my_transpose).to eq(
        [
          [0, 3, 6],
          [1, 4, 7],
          [2, 5, 8]
          ]
        )
    end
  end

  describe '#stock_picker' do
    subject(:stocks){ [ 10, 5, 8, 9, 12, 7, 6, 4  ]  }
    let(:answer) { stocks.stock_picker}

    it 'looks chronologically' do
      expect(answer[0]).to be < answer[1]
    end

    it 'outputs the most profitable days (indices)' do
      expect(answer).to eq( [1, 4] )
    end
  end


end
