n = gets.to_i
a = gets.split(" ").map(&:to_i).sort!

print "#{a.first} #{a.last} "

sum = 0
n.times do |i| 
  sum += a[i]
end

puts sum
