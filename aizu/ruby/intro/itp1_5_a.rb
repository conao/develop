while true
  h, w = gets.split(" ").map(&:to_i)
  if h == 0 && w == 0
    break
  end
  h.times do
    puts "#" * w
  end
  print "\n"
end
