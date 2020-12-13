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

def search(color, bags)
  containers = who_contains_me(color, bags)
  return color if containers.empty?
  
  return (containers + containers.map{ |c| search(c, bags)}).flatten.uniq
end

bags = load_bags
# Part 1 
ap search("shiny gold", bags).size


