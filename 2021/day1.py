with open("input.txt") as file:
  measurements = list(map(lambda x: int(x.rstrip()), file.readlines()))

n = len(measurements)
increases = 0

for idx, measurement in enumerate(measurements):
  if idx == n-1: 
    break 

  if measurements[idx+1] > measurement:
    increases += 1

print(increases)

