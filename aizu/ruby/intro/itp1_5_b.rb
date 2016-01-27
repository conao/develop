while true
  h, w = gets.split(" ").map(&:to_i)
  if h == 0 && w == 0
    break
  end
  puts "#" * w
  (h-2).times do
    puts "#" + "." * (w-2) + "#"
  end
  puts "#" * w
  print "\n"
end
