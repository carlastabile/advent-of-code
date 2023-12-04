require 'pry'

# read file 
lines = File.readlines("input.txt", chomp: true).map{ |x| x.split(":")[1]}

config = {red: 12, green: 13, blue: 14}

### Part 1 
games = lines.map{ |x| x.split(";")}
impossible = []

games = games.each_with_index do |game, idx|
  game.each do |g|
    set = g.split(",")
    set.each do |s|
      value, color = s.split(" ")

      ## If the value is bigger than the availability
      ## it's impossible to solve 
      impossible << idx + 1 if value.to_i > config[color.to_sym]
    end
  end
end

result = (1..lines.size).to_a - impossible.uniq 
puts result.sum

### Part 2 
games = lines.map{ |x| x.split(";")}
min_cubes = []

games = games.each_with_index do |game, idx|
  config = {red: 0, green: 0, blue: 0}
  
  game.each do |g|
    set = g.split(",")

    set.each do |s|
      value, color = s.split(" ")

      ## The min number of cubes is the max of the 
      ## ones in the set  
      config[color.to_sym] = [value.to_i, config[color.to_sym]].max
    end
    
  end
  min_cubes << config 
end

puts min_cubes.sum{ |games| games.values.inject(:*) }