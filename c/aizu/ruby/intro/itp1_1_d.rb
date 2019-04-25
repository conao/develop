a = Time.at(sec = gets().to_i)
puts a.utc.strftime("%-H:%-M:%-S")
