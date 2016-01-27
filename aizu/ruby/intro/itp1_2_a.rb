a, b = gets.split(" ").map(&:to_i)
if a < b
  msg = "a < b"
elsif a > b
  msg = "a > b"
else
  msg = "a == b"
end
puts "%s" % msg
