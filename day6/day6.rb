# Notes:
# answers for every group on the plane -- input 
# duplicates don't count
# \n\n -- group 
# \n == number of ppl in group 
# number of letters == number of questions
def load_groups
  File.readlines("input.txt", "\n\n", chomp: true)
end

def people_questions(groups)
  groups.map do |group|
    people = group.split("\n")

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
  group.gsub("\n", "").chars.uniq
end

# I love you Ruby 2.7 
# tally is life
puts result.flatten.tally.values.sum

# Part 2 
# Count letter that all people in group have
result = people_questions(groups).sum do |answers| 
          occurences = answers[:letters].tally
          occurences.select{ |_,v| v == answers[:people_count]}.length
        end

puts result

