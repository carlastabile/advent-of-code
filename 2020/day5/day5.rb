# Notes
# row_range = [0, 127]
# F = [0, data.length/2]
# B = [data.length/2, data.length-1]

# column_range = [0,7]
# R = F 
# L = B

# seat_id = row * 8 + column

def boarding_passes
  File.readlines("input.txt")
end 

def search_seat(boarding_pass, left, right, size)
  min = 0
  max = size

  for seat in boarding_pass.chars
    middle = (max + min) / 2
    if seat == left
      max = middle
    elsif seat == right
      min = middle + 1
    end
  end
  min
end

# Part 1 
seats = boarding_passes.map do |code|
  row = search_seat(code[0..-4], "F", "B", 127)
  column = search_seat(code[-4, code.length], "L", "R", 7)
  (row * 8) + column
end
puts seats.max


# Part 2 
total_seats = (seats.min..seats.max).to_a
puts total_seats.reject{ |seat| seats.sort.include?(seat) }
