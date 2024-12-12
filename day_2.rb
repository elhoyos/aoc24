input = <<IN
  7 6 4 2 1
  1 2 7 8 9
  9 7 6 2 1
  1 3 2 4 5
  8 6 4 4 1
  1 3 6 7 9  
IN

reports = File.readlines("./day_2_input").map { _1.split.map(&:to_i) }
# reports = input.each_line.map { _1.split.map(&:to_i) }

def safe?(reports)
  reports.transpose.map { _1.reduce(&:-) }.all? { _1 > 0 && _1 < 4 }
end

safe_reports = reports.count do |report|
  safe?([report[0..-2], report[1..-1]]) || 
  safe?([report[1..-1], report[0..-2]])
end

puts "Safe reports: #{safe_reports}"

safe_reports_with_dampener = reports.count do |report|
  safe?([report[0..-2], report[1..-1]]) || 
  safe?([report[1..-1], report[0..-2]]) ||
  (0..report.size-1).any? do |index|
    dampened = report.dup
    dampened.delete_at(index)
    safe?([dampened[0..-2], dampened[1..-1]]) ||
    safe?([dampened[1..-1], dampened[0..-2]])
  end
end

puts "Safe reports with Problem Dampener: #{safe_reports_with_dampener}"