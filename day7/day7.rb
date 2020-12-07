# Notes 
# rules -- input 
require "pry"
require "awesome_print"

def load_rules
  rules = {}

  File.readlines("input.txt", "\n", chomp: true).map do |line|
    string = line.gsub(/bags.|bags,|bag|contain/, ",")
    numbers = string.scan(/\d+/).map(&:to_i)
    # remove numbers 
    string = string.tr("0-9", "").split(",")
    #clean up 
    bags_colors = string.map(&:strip).reject(&:empty?)

    if bags_colors[1] == "no other"
      rules[bags_colors[0]] = nil
    else
      rules[bags_colors[0]] = { bags_colors[1] => numbers[0] }
    end

    if bags_colors[2] && bags_colors[2].length > 1
      rules[bags_colors[0]].merge({bags_colors[2] => numbers[1]})
    end
  end
  rules
end

ap load_rules