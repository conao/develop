while (a = gets.split.map(&:to_i).sort)[1] != 0 do
  puts "#{a[0]} #{a[1]}"
end
