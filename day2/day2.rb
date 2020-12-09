def read_policies  
  lines = File.read("input.txt").split("\n")
  
  lines.map do |line|
    data = line.split(/[\s|\-|: ']/).reject(&:empty?)
    {
      lower: data[0].to_i,
      higher: data[1].to_i,
      letter: data[2],
      password: data[3]
    }
  end
end

def valid1?(policy)
  count = policy[:password].scan(/#{policy[:letter]}/).length

  count >= policy[:lower] && count <= policy[:higher]
end

def valid2?(policy)
  idx1 = policy[:lower]
  idx2 = policy[:higher]
  password = policy[:password]

  (password[idx1-1] == policy[:letter] || 
  password[idx2-1] == policy[:letter]) && 
  !(password[idx1-1] == policy[:letter] && 
    password[idx2-1] == policy[:letter])
end

policies = read_policies
puts policies.count{ |policy| valid1?(policy) }
puts policies.count{ |policy| valid2?(policy) }