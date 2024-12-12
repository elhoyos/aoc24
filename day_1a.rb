require "csv"

# input = [
#   [3, 4],
#   [4, 3],
#   [2, 5],
#   [1, 3],
#   [3, 9],
#   [3, 3],
# ]
#
# # $ ruby day_1a.rb
# # Total distance: 11

input = []
CSV.foreach("./day_1a_input", col_sep: "   ") do |row|
  input << [row[0].to_i, row[1].to_i]
end

group_1, group_2 = input.each_with_object([[], []]) do |(id_group_1, id_group_2), ids_by_group|
  ids_by_group[0] << id_group_1
  ids_by_group[1] << id_group_2
end

total_distance = group_1.sort.zip(group_2.sort).reduce(0) do |acc, (id_group_1, id_group_2)|
  acc += (id_group_1 - id_group_2).abs
end

puts "Total distance: #{total_distance}"