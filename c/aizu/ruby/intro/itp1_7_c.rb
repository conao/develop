while (r, c = gets.split(" ").map(&:to_i)) != [0, 0] do
  r.times do
    array = gets.split(" ").map(&:to_i)
    printf("%s %d", array.join(" "), array)
  end
end








