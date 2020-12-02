def read_input():
  data = []
  with open('input.txt', 'r') as file:
    data = [int(line.rstrip('\n')) for line in file]

  return data 

def find_sum_2020():
  data = read_input()

  for elem in data: 
    for other_elem in data: 
      if elem + other_elem == 2020:
        return [elem, other_elem]

  return []

print(find_sum_2020())