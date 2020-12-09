require "set"

def load_passports
  rows = File.read("input.txt").split("\n\n")
  rows.map do |row|
    data = row.split(/[\s|\n]/).reject(&:empty?)

    data.each_with_object({}) do |field, hsh| 
      key,value = field.split(":")
      hsh[key] = value
    end.transform_keys(&:to_sym)
  end
end

def all_fields?(passport, fields = [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid])
  (fields - passport.keys).empty?
end

def hgt_valid?(hgt)
  metric = hgt[-2..-1]
  height = hgt.delete_suffix(metric) 

  if metric == "cm"
    return false unless in_range?(height.to_i, 150, 193)
  elsif metric == "in"
    return false unless in_range?(height.to_i, 59, 76)
  else 
    return false
  end

  true
end

def length_valid?(field, length)
  field.length == length
end 

def in_range?(field, lower, higher)
  field.to_i >= lower && field.to_i <= higher
end 

def matches?(regex, field)
  !regex.match(field).nil?
end 

passports = load_passports

# Part 1 
all_fields_passport = passports.select { |p| all_fields?(p) }
puts all_fields_passport.count

# Part 2 
validations = {
  byr: ->(field) { length_valid?(field, 4) && in_range?(field, 1920, 2002) }, 
  iyr: ->(field) { length_valid?(field, 4) && in_range?(field, 2010, 2020) },
  eyr: ->(field) { length_valid?(field, 4) && in_range?(field, 2020, 2030) },
  hgt: ->(field) { hgt_valid?(field) },
  hcl: ->(field) { matches?(/#([a-f|0-9]){6}$/, field) },
  ecl: ->(field) { %w[amb blu brn gry grn hzl oth].include?(field) },
  pid: ->(field) { matches?(/([0-9]){9}$/, field) }
}

count = 0
all_fields_passport.each do |passport|
  valids = validations.map do |field, validation|
            validation.call(passport[field])
          end.compact
  count += 1 if valids.all?
end 
puts count





