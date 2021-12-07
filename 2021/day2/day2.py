with open("input.txt") as file:
  instructions = list(map(lambda x: x.rstrip().split(' '), file.readlines()))

# Part 1 
submarine = {"horizontal": 0, "depth": 0}

for [direction, units] in instructions: 
  if direction == "forward":
    submarine["horizontal"] += int(units)
  elif direction == "up": 
    submarine["depth"] -= int(units)
  elif direction == "down":
    submarine["depth"] += int(units)

print(submarine["horizontal"] * submarine["depth"])

# Part 2 
submarine = {"horizontal": 0, "depth": 0, "aim": 0}
for [direction, units] in instructions: 

  if direction == "forward":
    submarine["horizontal"] += int(units)
    submarine["depth"] += submarine["aim"] * int(units)
  elif direction == "up": 
    submarine["aim"] -= int(units)
  elif direction == "down":
    submarine["aim"] += int(units)


print(submarine["horizontal"] * submarine["depth"])