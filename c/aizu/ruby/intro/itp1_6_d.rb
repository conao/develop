x, y = gets.split(" ").map(&:to_i)
a = Array.new(x){gets.split(" ").map(&:to_i)}
b = Array.new(y){gets.to_i}

x.times do |i|
  element = 0
  y.times do |j|
    element += a[i][j] * b[j]
  end
  puts element
end
