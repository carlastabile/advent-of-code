# Notes:
# answers for every group on the plane -- input 
# duplicates don't count
# \n\n -- group 
# \n == number of ppl in group 
# number of letters == number of questions
require "pry"
def load_groups
  File.readlines("input.txt", "\n\n", chomp: true)
end

def uniq_letters(group)
  group.gsub("\n", "").chars.uniq
end

def split_people(group)
  group.split("\n")
end

# Part 1 
# Count diff letters per group and sum it up
result = load_groups.map do |group|
  uniq_letters(group)
end

# I love you Ruby 2.7 
# tally is life
puts result.flatten.tally.values.sum


