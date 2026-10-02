File.open("data.txt") do |file|
  file.each_line { |line| puts line }
end