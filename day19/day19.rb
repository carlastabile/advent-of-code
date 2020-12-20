# the number of messages that completely match rule 0
require "pry"

def load
  data = File.readlines("input.txt", chomp: true)
  idx = data.index("")
  [data[0,idx], data[idx+1, data.size]]
end

def parse_rule(rule)
  rule.strip.split(" ").map(&:to_i)
end

def build(rules)
  rules.each_with_object([]) do |rule, memo|
    parts = rule.split(":")
    rule_number = parts[0].to_i
    data = parts[1]
    
    data = if data.strip.start_with?("\"")
      data.gsub(/\"/, "").strip
    elsif data.include?("|")
      data.strip.split("|").map{ |r| parse_rule(r) }
    else 
      parse_rule(data)    
    end
    

    memo << {
      rule_number => data
    }
  end
end
