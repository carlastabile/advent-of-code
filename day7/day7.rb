require "pry"

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
puts load_bags
