def load_map
	rows = File.read("input.txt").split("\n")
  rows.map{ |row| row.chars }
end

def count_trees(map, slope_right, slope_down)
  trees = 0
  
  # starting point 
  x = slope_right 
  y = slope_down

  while y < map.length do 
    if x > map[y].length - 1
      x = x % map[y].length
    end
      
    trees += 1 if map[y][x] == "#"

    x += slope_right 
    y += slope_down
  end

  trees
end

map = load_map

puts "Part 1"
puts count_trees(map, 3, 1)


puts "Part 2"

slopes = [[1,1],[3,1],[5,1],[7,1], [1,2]]
puts slopes.map{ |slope| count_trees(map, *slope)}.reduce(:*)


