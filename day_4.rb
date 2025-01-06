input = <<IN
  MMMSXXMASM
  MSAMXMSMSA
  AMXSXMAAMM
  MSAMASMSMX
  XMASAMXAMM
  XXAMMXXAMA
  SMSMSASXSS
  SAXAMASAAA
  MAMMMXMMMM
  MXMXAXMASX
IN

XMAS = "XMAS"
MAS = "MAS"

input_split = File.readlines("./day_4_input").map { _1.lstrip.rstrip.chars }
# input_split = input.each_line.map { _1.lstrip.rstrip.chars }

# pp input_split

def extract(range, of:)
  range
    .reduce([]) do |word, (i, j)|
      return "" if i < 0 || j < 0
      char = (of[j] || [])[i]
      # pp "#{i}, #{j}: #{char}" if range == [[6, 4], [5, 4], [4, 4], [3, 4]]
      word << char
    end
    .join
end

def matches_from(i, j, of:)
  matches = []

  ranges = [
    [[i, j], [i, j-1], [i, j-2], [i, j-3]], # up
    [[i, j], [i, j+1], [i, j+2], [i, j+3]], # down
    [[i, j], [i+1, j], [i+2, j], [i+3, j]], # right
    [[i, j], [i-1, j], [i-2, j], [i-3, j]], # left
    [[i, j], [i+1, j-1], [i+2, j-2], [i+3, j-3]], # right_up
    [[i, j], [i-1, j-1], [i-2, j-2], [i-3, j-3]], # left_up
    [[i, j], [i+1, j+1], [i+2, j+2], [i+3, j+3]], # right_down
    [[i, j], [i-1, j+1], [i-2, j+2], [i-3, j+3]], # left_down
  ].each do |range|
    word = extract(range, of:)
    # puts "#{word} — #{range}: #{word == XMAS || word.reverse == XMAS}" if range[0] == [6, 4]
    matches << range if word == XMAS || word.reverse == XMAS
  end

  matches
end

def x_mas_matches_from(i, j, of:)
  matches = []

  ranges = [
    [[i, j], [i+1, j+1], [i+2, j+2]], # right_down
    [[i+2, j], [i+1, j+1], [i, j+2]], # left_down
  ]

  x_mas = ranges.all? do |range|
    word = extract(range, of:)
    # puts "#{word} — #{range}: #{word == MAS || word.reverse == MAS}" if i == 3 && j == 2
    word == MAS || word.reverse == MAS
  end

  matches = ranges if x_mas

  matches
end

puzzler = Enumerator.new do |y|
  i = 0
  i_len = input_split.first.size
  j_len = input_split.size
  while i < i_len do
    j = 0

    while j < j_len do
      y << [i, j, input_split]

      j += 1
    end

    i += 1
  end
end

xmas_count = 0
# { range => 1 } represents a letter in the 2D matrix of input_split that is part of a xmas match
matches_map = {}
res_map = []
puzzler.each do |i, j, input_split|
  res_map[j] ||= []
  res_map[j][i] = matches_map["#{i}#{j}"] || "."

  matches_from(i, j, of: input_split).each do |matches|
    xmas_count += 1 unless matches_map[matches.sort]
    matches_map[matches.sort] = 1

    matches.each do |(match_i, match_j)|
      res_map[match_j] ||= []
      res_map[match_j][match_i] = input_split[match_j][match_i]
    end
  end
end

puts "XMAS appearances: #{xmas_count}"

# puts ""
# res_map.each { puts _1.join }


########## Part two:

xmas_count = 0
matches_map = {}
res_map = []
puzzler.each do |i, j, input_split|
  res_map[j] ||= []
  res_map[j][i] ||= "."

  x_mas_matches = x_mas_matches_from(i, j, of: input_split)

  xmas_count += 1 if x_mas_matches.count > 0

  x_mas_matches.each do |matches|
    matches.each do |(match_i, match_j)|
      res_map[match_j] ||= []
      res_map[match_j][match_i] = input_split[match_j][match_i]
    end
  end
end

puts "X_MAS appearances: #{xmas_count}"

# puts ""
# res_map.each { puts _1.join }
