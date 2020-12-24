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
  adjs = []
  m = seatmap.size 
  n = seatmap[x].size

  adjs <<  seatmap[x - 1][y - 1] if x > 0 && y > 0
  adjs <<  seatmap[x][y - 1] if y > 0
  adjs <<  seatmap[x + 1][y - 1] if y > 0 && x + 1 < m
  adjs <<  seatmap[x - 1][y] if x > 0
  adjs <<  seatmap[x + 1][y] if x+1 < m
  adjs <<  seatmap[x - 1][y + 1] if x > 0 && y + 1 < n
  adjs <<  seatmap[x][y + 1] if y + 1 < n
  adjs <<  seatmap[x + 1][y + 1] if x + 1 < m && y + 1 < n
  adjs
end

def occupied?(adjs)
  # puts "occupied? -- #{adjs}"
  adjs.any?{ |a| a == "#" }
end

def four_or_more_occupied?(adjs)
  # puts "occupied seats #{adjs.count{ |a| a == "#" }}"
  adjs.count{ |a| a == "#" } >= 4
end

def print(seatmap)
  seatmap.each{ |row| puts row.join("") }
end

def sit_them(seatmap)
  seatmap_copy = Marshal.load(Marshal.dump(seatmap))

  seatmap_copy.each_with_index do |row, i|
    row.each_with_index do |seat, j|
      next if seat == "."

      adjs = adjacents(seatmap, i, j)

      seatmap_copy[i][j] = "#" if seat == "L" && !occupied?(adjs)

      seatmap_copy[i][j] = "L" if seat == "#" && four_or_more_occupied?(adjs)  
    end
  end
  seatmap_copy
end

rows = File.read("input.txt").split("\n")
seatmap ||= rows.map{ |row| row.chars }

new_one = seatmap
loop do 
  prev = new_one
  new_one = sit_them(prev)
  break if prev == new_one
end

puts new_one.sum{ |row| row.count{ |a| a == "#" } }


