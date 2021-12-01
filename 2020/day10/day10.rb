# adapter + 1, 2 o 3 
# pick min difference
# What is the number of 1-jolt differences multiplied by the number of 3-jolt differences?
require "pry"

def adapters
  File.readlines("input.txt", chomp: true).map(&:to_i).sort
end

def difference(n)
  dfs = [1,2,3].map{ |d| n + d }
  adapters.find{ |m| dfs.include?(m) }
end

def part1
  # adapter.max + 3 (max joltage)
  max = adapters.max + 3
  result = { 1 => 1, 3 => 1}

  adapters.each do |adapter|
    break if adapter == max - 3
    diff = difference(adapter)
    result[diff - adapter] += 1
  end
  result.values.reduce(:*)
end

def part2
  options = Hash.new(0)
  options[0] = 1

  adapters.each do |adapter|
    options[adapter] = [1, 2, 3].sum { |diff| options[adapter - diff] }
  end
  options[adapters.max]
end

puts part1
puts part2