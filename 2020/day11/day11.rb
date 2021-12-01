# floor (.), an empty seat (L), or an occupied seat (#)

# If a seat is empty (L) and there are no occupied seats adjacent to it,
# the seat becomes occupied.
#
# If a seat is occupied (#) and four or more seats adjacent to it 
# are also occupied, the seat becomes empty.
# 
# Otherwise, the seat's state does not change.
#
# Floor (.) never changes; seats don't move, 
# and nobody sits on the floor.

# How many seats end up occupied? when no seats change state!
require "pry"
require "awesome_print"

def adjacents(seatmap, x, y)
  adjs = { row: [], col: [], diag1: [], diag2: [] }
  m = seatmap.size 
  n = seatmap[x].size

  adjs[:diag1] <<  seatmap[x - 1][y - 1] if x > 0 && y > 0
  adjs[:row]   <<  seatmap[x][y - 1] if y > 0
  adjs[:diag2] <<  seatmap[x + 1][y - 1] if y > 0 && x + 1 < m
  adjs[:col]   <<  seatmap[x - 1][y] if x > 0
  adjs[:col]   <<  seatmap[x + 1][y] if x+1 < m
  adjs[:diag2] <<  seatmap[x - 1][y + 1] if x > 0 && y + 1 < n
  adjs[:row]   <<  seatmap[x][y + 1] if y + 1 < n
  adjs[:diag1] <<  seatmap[x + 1][y + 1] if x + 1 < m && y + 1 < n
  adjs
end

def directional(seatmap, x, y)
  #  row = numberOfRows - column -1.
  result = { row: [], col: [], diag1: [], diag2: [] }
  
  seatmap.each_with_index do |row, i|
    result[:row] = row if i == x 
    
    row.each_with_index do |col, j| 
      result[:col] << col if j == y  
      result[:diag1] << col if i == j 
      result[:diag2] << col if i == row.length - j - 1 
    end 
  end

  result.each do |k,v|
    idx = result[k].index("L")
    next unless idx 

    result[k] = result[k].slice(0, idx + 1)
  end
  result
end

def occupied?(adjs)
  adjs.values.flatten.any?{ |a| a == "#" }
end

def n_or_more_occupied?(n, adjs)
  adjs.values.flatten.count{ |a| a == "#" } >= n
end

def print(seatmap)
  seatmap.each{ |row| puts row.join("") }
end

def sit_them(seatmap, tolerance, how_to_sit: :adjacents)
  seatmap_copy = Marshal.load(Marshal.dump(seatmap))

  puts "----------------------------"
  print(seatmap_copy)
  seatmap_copy.each_with_index do |row, i|
    row.each_with_index do |seat, j|
      next if seat == "."

      adjs = how_to_sit == :adjacents ? adjacents(seatmap, i, j) : directional(seatmap, i, j)
      puts "occupied? #{occupied?(adjs)} n_or_more_occupied? #{n_or_more_occupied?(tolerance, adjs)}"
      puts "#{i}#{j} #{seat} adjs #{adjs}"
      seatmap_copy[i][j] = "#" if seat == "L" && !occupied?(adjs)

      seatmap_copy[i][j] = "L" if seat == "#" && n_or_more_occupied?(tolerance, adjs)  
    end
  end
  puts "\n"
  print(seatmap_copy)
  seatmap_copy
end

rows = File.read("input.txt").split("\n")
seatmap ||= rows.map{ |row| row.chars }

# Part 1 
tolerance = 4 
new_one = seatmap
loop do 
  prev = new_one
  new_one = sit_them(prev, tolerance)
  break if prev == new_one
end

puts new_one.sum{ |row| row.count{ |a| a == "#" } }

# Part 2 
# tolerance = 5 
# count = 0
# new_one = seatmap
# loop do 
#   prev = new_one
#   new_one = sit_them(prev, tolerance, how_to_sit: :directional)
#   count += 1
#   break if prev == new_one || count == 2
# end



