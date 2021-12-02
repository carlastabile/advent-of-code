with open("input.txt") as file:
  measurements = list(map(lambda x: int(x.rstrip()), file.readlines()))

def calculateIncrease(measurements):
  increases, n = 0, len(measurements)

  for idx, measurement in enumerate(measurements):
    if idx < n - 1 and measurements[idx+1] > measurement:
      increases += 1
  return increases

# Part 1
print(calculateIncrease(measurements))

# Part 2 
result = [x + measurements[idx+1] + measurements[idx+2] if idx < len(measurements) - 2 else 0 for idx, x in enumerate(measurements)]
result = [x for x in result if x != 0]
print(calculateIncrease(result))
