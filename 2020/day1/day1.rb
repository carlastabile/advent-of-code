require "pry"

numbers = File.readlines("input.txt", chomp: true).map(&:to_i)

#Part 1 
puts numbers.combination(2).find {|a, b| a + b == 2020 }.reduce(1,:*)

# Part 2 
puts numbers.combination(3).find {|a, b, c| a + b + c == 2020 }.reduce(1,:*)