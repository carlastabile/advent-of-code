require "pry"

def load_bags
  bags = {}
  File.readlines("input.txt", chomp: true).each do |line|
    main_bag, inner_bags = line.split(/ bags contain /)
    
    bags[main_bag] = inner_bags.split(", ").each_with_object([]) do |bag, memo|
      
      amount_match = bag.match(/\d/) 
      bag_match = bag.match(/\D+/)[0].split(/ bag/).map(&:lstrip)[0]

      if bag_match == "no other"
        nil
      else
        memo << {
          amount: amount_match ? amount_match[0].to_i : nil,
          bag: bag_match
        }
      end
    end
  end
  bags
end
