# frozen_string_literal: true

# array helpers
module ArrayHelpers
  def rows_length_four(nested_array)
    fours = []
    nested_array.each do |row|
      n = row.length >= 4 ? 4 : row.length
      row.each_cons(n) { |f| fours << f }
    end
    fours
  end

  def columns_length_four(nested_array)
    fours = []
    nested_array.transpose.each do |column|
      n = column.length >= 4 ? 4 : column.length
      column.each_cons(n) { |f| fours << f }
    end
    fours
  end

  def diagonals_length_four(nested_array)
    d = diagonals(nested_array)

    fours_or_more = d.filter { |e| e.size >= 4 }

    fours_or_more.map { |a| a.each_cons(4).map { |b| b } }.flatten(1).filter { |c| c.size == 4 }
  end

  # https://stackoverflow.com/a/28075593
  def diagonals(nested_array)
    padding = nested_array.size - 1
    padded_matrix = []

    nested_array.each do |row|
      inverse_padding = nested_array.size - padding
      to_add = (([nil] * inverse_padding) + row + ([nil] * padding))
      padded_matrix << to_add
      padding -= 1
    end

    padded_matrix.transpose.map(&:compact).reject(&:empty?)
  end
end
