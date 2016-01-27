n = gets.to_i
a = Array.new(4).map!{[1..13]}
 
n.times do
  b, c = gets.split(" ")
  case b
  when "S"; a[0][c.to_i-1] = -1
  when "H"; a[1][c.to_i-1] = -1
  when "C"; a[2][c.to_i-1] = -1
  when "D"; a[3][c.to_i-1] = -1
  end
end
 
4.times do |i| 
  13.times do |j| 
    if a[i][j] != -1
      print case i
            when 0; "S "
            when 1; "H "
            when 2; "C "
            when 3; "D "
            end
      puts j+1
    end
  end
end
