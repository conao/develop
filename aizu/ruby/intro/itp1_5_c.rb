while (h, w = gets.split(" ").map(&:to_i)) != [0, 0]
  line_a = ("#" * (w/2)).split(//).join(".")
  if w % 2 == 0
    line_a << "."
    line_b = line_a.reverse
  else
    line_a << ".#"
    line_b = (line_a.reverse << ".").split(//).drop(1).join
  end
  
  (h/2).times do
    puts line_a, line_b
  end
  if h % 2 == 1
    puts line_a
  end
  print "\n"
end

