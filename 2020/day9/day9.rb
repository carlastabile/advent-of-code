# find the first number in the list (after the preamble) 
# which is not the sum of two of the 25 numbers before it

def numbers
  File.readlines("input.txt", chomp: true).map(&:to_i)
end

# returns nil if no combination is found
def find_sum(left_offset, right_offset, number)
  list = numbers[left_offset,right_offset]
  list.combination(2).find {|a, b| a + b == number }
end

def find_number(preamble)
  numbers.each_with_index do |number, idx|
    next if idx < preamble

    return number if find_sum(idx - preamble, idx + preamble, number).nil?
  end
end

def find_sum_contigous_set(number)
  cardinalities = (2..100)

  cardinalities.each_with_object([]) do |cardinality, memo|
    memo << numbers.each_cons(cardinality).select { |cons| cons.sum == number }
  end.reject(&:empty?).flatten  
end

def encryption_weakness(set)
  set.min + set.max 
end 

# Part 1 
number =  find_number(25)

# Part 2 
set = find_sum_contigous_set(number)
puts encryption_weakness(set)