require "pry"

LIMITS = {
  N: 0,
  E: 0,
  S: 0,
  W: 0,
}

def turn(side, degrees, from)
  position = LIMITS.keys.index(from) 

  case side
  when :R
    position = (position + (degrees/90)) % 4
  when :L 
    position = (position - (degrees/90)) % 4
  end
  LIMITS.keys[position]
end

def manhattan_distance
  (LIMITS[:E] - LIMITS[:W]).abs + (LIMITS[:N] - LIMITS[:S]).abs
end

nav_instructions = File.readlines("input.txt",chomp: true).each_with_object([]) do |nav, memo|
  letter = nav.match(/[A-Z]/)[0].to_sym
  number = nav.match(/\d+/)[0].to_i
  memo << {
    letter => number
  }
end

# add to east and west repectively 
facing = :E

nav_instructions.each do |nav|
  direction, units = nav.keys[0].to_sym, nav.values[0]

  if %i[L R].include?(direction)
    facing = turn(direction, units, facing)
  elsif direction == :F
    LIMITS[facing] += units 
  else
    LIMITS[direction] += units  
  end
end

puts manhattan_distance