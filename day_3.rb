input = <<~IN
  xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
IN

input = File.read("./day_3_input")

added_mul = input.scan(/mul\((\d{1,3}),(\d{1,3})\)/).sum { _1.map(&:to_i).reduce(&:*) }

puts "all mul added: #{added_mul}"

def conditioned_added_mul(input)
  input = "do()#{input}don't()"
  input.scan(/(?<=do\(\)).*?(?=don't\(\))/m)
    .map do
      _1.scan(/(?:mul\((\d{1,3}),(\d{1,3})\))/)
    end
    .flatten(1)
    .sum do
      _1.map(&:to_i).reduce(&:*)
    end
end

input = <<~IN
  xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
IN

input = File.read("./day_3_input")
puts "all mul added conditioned: #{conditioned_added_mul(input)}"
