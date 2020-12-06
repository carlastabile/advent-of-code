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

def present?(passport, fields = [:byr, :iyr, :eyr, :hgt, :hcl, :ecl, :pid])
  (fields - passport.keys).empty?
end

def hgt_valid?(hgt)

  if hgt.end_with?("cm")
    value = hgt.split("cm")[0]
    return false unless value.scan(/\D/).empty? 
    return false if value.to_i < 150 || value.to_i > 193
  end

  if hgt.end_with?("in")
    value = hgt.split("in")[0]
    return false unless value.scan(/\D/).empty?
    return false if value.to_i < 59 || value.to_i > 76
  end

  true
end

def length_valid?(field, length)
  !field.scan(/(\d){#{length}}$/).empty?
end 

def in_range?(field, lower, higher)
  field.to_i >= lower && field.to_i <= higher
end 

passports = load_passports

# Part 1 
puts passports.count { |p| present?(p) }

# Part 2 
validations = {
  byr: ->(field) { length_valid?(field, 4) && in_range?(field, 1920, 2002) }, 
  iyr: ->(field) { length_valid?(field, 4) && in_range?(field, 2010, 2020) },
  eyr: ->(field) { length_valid?(field, 4) && in_range?(field, 2020, 2030) },
  hgt: ->(field) { hgt_valid?(field) },
  hcl: ->(field) { !/#([a-f|0-9]){6}$/.match(field).nil? },
  ecl: ->(field) { %w[amb blu brn gry grn hzl oth].include?(field) },
  pid: ->(field) { !/([0-9]){9}$/.match(field).nil? }
}

count = 0
passports.each do |passport|
  next unless present?(passport)
  puts "-----"
  count += 1 if validations.map do |field, validation|
                  is = validation.call(passport[field])
                  puts "for #{field} #{passport[field]} validation #{is}"
                end.compact.all?
end 
puts count





