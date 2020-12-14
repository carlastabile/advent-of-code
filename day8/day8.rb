require "pry"

def instructions
  File.readlines("input.txt", chomp: true).each_with_object([]) do |line, acc|
    data = line.split(" ")
    acc << {
      operation: data[0].to_sym, 
      argument: data[1].to_i, 
      executed: false
    }
  end
end

def acc(instructions)
  acc = 0
  idx = 0

  while true
    instruction = instructions[idx]
    
    break if instruction[:executed]
    
    if instruction[:operation] == :nop
      instruction[:executed] = true
      idx += 1 
      next 
    end

    acc += instruction[:argument] if instruction[:operation] == :acc

    instruction[:operation] == :jmp ? idx += instruction[:argument] : idx += 1

    instruction[:executed] = true
  end
  acc
end

# Part 1 
puts acc(instructions)