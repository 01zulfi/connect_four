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
end
