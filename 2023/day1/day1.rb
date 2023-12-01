require 'pry'
# read file 
lines = File.readlines("input.txt", chomp: true)

##### Part 1 
# extract only numbers 
calibration = lines.map {|x| x.scan(/\d/).join('')}

# sum first and last 
result = calibration.sum{|x| "#{x[0]}#{x[-1]}".to_i }
puts result

##### Part 2 
words = %w[one two three four five six seven eight nine]

## extract numbers and sum first and last 
result = lines.sum do |line|
  numbers = line.scan(/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/).flatten

  first = words.index(numbers[0]) ? words.index(numbers[0]) + 1 : numbers[0]
  last = words.index(numbers[-1]) ? words.index(numbers[-1]) + 1 : numbers[-1]
  
  "#{first}#{last}".to_i
end
puts result