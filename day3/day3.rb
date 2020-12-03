require 'awesome_print'

def load_map
	rows = File.read("input.txt").split("\n")
  rows.map{ |row| row.chars }
end

def count_trees(map, slope_right: 3, slope_down: 1)
  trees = 0
  m = map.length 
  n = map[0].length

  map.each_with_index do |row, i|
    row.with_index do |_, j|
      break if n - slope_right <= j 

      elem = row[i+slope_down][j+slope_right]
      trees += 1 if elem == "#"
    end
  end

  trees
end

map = load_trees
puts count_trees(map)