File.open("data.txt", "r") do |file|
  puts file.read
end  # 文件在这里自动关闭，不需要 ensure