# frozen_string_literal: true

require_relative '../lib/array_helpers'

describe ArrayHelpers do
  describe '#rows_length_four' do
    context 'when array is empty' do
      subject(:dummy_class) { Class.new { extend ArrayHelpers } }

      it 'returns empty array' do
        array = []
        expect(dummy_class.rows_length_four(array)).to match_array([])
      end
    end

    context 'when a nested 4x4 (or less) array is given' do
      subject(:dummy_class) { Class.new { extend ArrayHelpers } }

      it 'returns the same array' do
        array = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        expect(dummy_class.rows_length_four(array)).to match_array(array)
      end
    end

    context 'when a nested 5x5 (or more) array is given' do
      subject(:dummy_class) { Class.new { extend ArrayHelpers } }

      it 'returns the all fours combinations' do
        array = [[1, 2, 3, 4, 5], [6, 7, 8, 9, 10], [11, 12, 13, 14, 15]]
        expect(dummy_class.rows_length_four(array)).to match_array([[1, 2, 3, 4],
                                                                    [2, 3, 4, 5],
                                                                    [6, 7, 8, 9],
                                                                    [7, 8, 9, 10],
                                                                    [11, 12, 13, 14],
                                                                    [12, 13, 14, 15]])
      end
    end
  end

  describe '#columns_length_four' do
    context 'when array is empty' do
      subject(:dummy_class) { Class.new { extend ArrayHelpers } }

      it 'returns empty array' do
        array = []
        expect(dummy_class.columns_length_four(array)).to match_array([])
      end
    end

    context 'when a nested 4x4 (or less) array is given' do
      subject(:dummy_class) { Class.new { extend ArrayHelpers } }

      it 'returns the transposed array' do
        array = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
        expect(dummy_class.columns_length_four(array)).to match_array(array.transpose)
      end
    end

    context 'when a nested 5x5 (or more) array is given' do
      subject(:dummy_class) { Class.new { extend ArrayHelpers } }

      it 'returns the all four combinations' do
        array = [[1, 2, 3], [6, 7, 8], [11, 12, 13], [16, 17, 18], [21, 22, 23]]
        expect(dummy_class.columns_length_four(array)).to match_array([[1, 6, 11, 16], [6, 11, 16, 21], [2, 7, 12, 17],
                                                                       [7, 12, 17, 22], [3, 8, 13, 18],
                                                                       [8, 13, 18, 23]])
      end
    end
  end
end