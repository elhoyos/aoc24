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
# # $ ruby day_1b.rb
# # Similarity score: 31

input = []
CSV.foreach("./day_1_input", col_sep: "   ") do |row|
  input << [row[0].to_i, row[1].to_i]
end

similarity_score = input
  .each_with_object({}) do |(id_group_1, id_group_2), ids_count|
    ids_count[id_group_1] ||= [0, 0]
    ids_count[id_group_2] ||= [0, 0]
    ids_count[id_group_1][0] += 1
    ids_count[id_group_2][1] += 1
  end
  .each_with_object({}) do |(id, (count_in_group_1, count_in_group_2)), ids_score|
    next if count_in_group_1 == 0
    ids_score[id] = id * count_in_group_1 * count_in_group_2
  end
  .values
  .sum

puts "Similarity score: #{similarity_score}"