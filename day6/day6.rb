# Notes:
# answers for every group on the plane -- input 
# duplicates don't count
# \n\n -- group 
# \n == number of ppl in group 
# number of letters == number of questions
require "pry"
require "awesome_print"
def load_groups
  File.readlines("input.txt", "\n\n", chomp: true)
end

def uniq_letters(group)
  group.gsub("\n", "").chars.uniq
end

def split_people(group)
  group.split("\n")
end

def build_people(groups)
  groups.map do |group|
    people = split_people(group)

    {
      people_count: people.length,
      letters: group.gsub("\n", "").chars
    }
  end
end

groups = load_groups
# Part 1 
# Count diff letters per group and sum it up
result = groups.map do |group|
  uniq_letters(group)
end

# I love you Ruby 2.7 
# tally is life
puts result.flatten.tally.values.sum

# Part 2 
# Count letter that all people in group have
count = 0
build_people(groups).each do |answers| 
  occurences = answers[:letters].tally
  count += occurences.select{ |_,v| v == answers[:people_count]}.length
end
puts count


