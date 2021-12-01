require "pry"

LIMITS = {
  N: 0,
  E: 0,
  S: 0,
  W: 0,
}

nav_instructions = File.readlines("input.txt",chomp: true).each_with_object([]) do |nav, memo|
  letter = nav.match(/[A-Z]/)[0].to_sym
  number = nav.match(/\d+/)[0].to_i
  memo << {
    letter => number
  }
end

def turn(side, degrees, from)
  position = LIMITS.keys.index(from) 

  case side
  when :R
    position = (position + (degrees/90)) % 4
  when :L 
    position = (position - (degrees/90)) % 4
  end
  puts "From #{from} #{degrees} degrees to #{side} -> #{LIMITS.keys[position]}"
  LIMITS.keys[position]
end

def manhattan_distance
  (LIMITS[:E] - LIMITS[:W]).abs + (LIMITS[:N] - LIMITS[:S]).abs
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
  # puts "#{direction}#{units} -- #{LIMITS} facing #{facing}"  
end

def part2(nav_instructions)
  facing = :E

  waypoint = { N: 1, E: 10 }
  limits = { N: 0, E: 0, S: 0, W: 0 }

  nav_instructions.each do |nav|
    direction, units = nav.keys[0].to_sym, nav.values[0]
    puts "#{direction}#{units}"

    if %i[N S E W].include?(manhattan_distancerection)
      waypoint[direction] += units 
    elsif direction == :F
      limits.each {|k, v| waypoint[k] * units if waypoint.keys.include?(k) }
    elsif %i[L R].include?(direction)
      puts "Turning waypoint from #{waypoint}"
      turned = [] 
      waypoint.each do |k,v| turned << turn(direction, units, k) end
      waypoint = turned.each_with_object({}) do |k, hash|
        hash.merge(k: waypoint)
      puts "To #{turned}"
    end
  end
end


puts part2(nav_instructions)
