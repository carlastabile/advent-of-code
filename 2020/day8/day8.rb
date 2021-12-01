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

def run_program(instructions)
  acc = 0
  idx = 0
  n = instructions.size 
  result = {}

  while true
    instruction = instructions[idx]

    return { acc: acc, idx: idx, terminated: true } if idx >= n
    return { acc: acc, idx: idx, terminated: false } if instruction[:executed]
    
    if instruction[:operation] == :nop
      instruction[:executed] = true 
      idx += 1 
      next 
    end

    acc += instruction[:argument] if instruction[:operation] == :acc

    instruction[:operation] == :jmp ? idx += instruction[:argument] : idx += 1

    instruction[:executed] = true
  end
  { acc: acc, idx: idx, terminated: true }
end

def generate_combination(instructions, idx)
  new_instructions = Marshal.load(Marshal.dump(instructions))
  operation = new_instructions[idx][:operation]

  new_instructions[idx][:operation] = if operation == :jmp 
                                        :nop
                                      elsif operation == :nop
                                        :jmp
                                      end  
  new_instructions
end

def switch_operations_to_terminate(instructions)
  instructions.each_with_index do |instruction, idx|
    next unless %i[jmp nop].include? instruction[:operation]

    combination = generate_combination(instructions, idx)
    accum = run_program(combination)
    return accum if accum[:terminated] 
  end
  accum
end

# Part 1 
puts run_program(instructions)[:acc]

# Part 2 
puts switch_operations_to_terminate(instructions)[:acc]