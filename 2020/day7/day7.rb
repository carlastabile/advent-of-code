require "pry"
require "awesome_print"

def load_bags
  bags = {}
  File.readlines("input.txt", chomp: true).each do |line|
    main_bag, inner_bags = line.split(/ bags contain /)
    
    bags[main_bag] = inner_bags.split(", ").map do |bag|
      
      amount_match = bag.match(/\d/) 
      bag_match = bag.match(/\D+/)[0].split(/ bag/).map(&:lstrip)[0]

      {
        amount: amount_match ? amount_match[0].to_i : nil,
        bag: bag_match
      } unless bag_match == "no other"
    end.compact
  end
  bags
end

def who_contains_me(color, bags)
  who = []
  bags.select do |bag, contained|
    who << bag unless contained.select { |bag| bag[:bag] if bag[:bag] == color}.empty?
  end
  who
end

# for some weird reason my approach here 
# was to count who contains my bag 
def search_containers(color, bags)
  containers = who_contains_me(color, bags)
  if containers.empty?
    return color 
  end
  return (containers + containers.map{ |c| search_containers(c, bags)}).flatten.uniq
end


def sum_containers(color, bags)
  children = bags[color]
  
  if children.nil? || children.empty?
    return 0
  end

  sum = bags[color].map{ |elem| elem[:amount]}.sum
  return sum + children.sum{ |c| c[:amount] * sum_containers(c[:bag], bags)}
end

bags = load_bags
# Part 1 
puts search_containers("shiny gold", bags).size

# Part 2 
puts sum_containers("shiny gold", bags)

