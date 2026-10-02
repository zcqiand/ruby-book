file = File.open("data.txt", "r")
begin
  content = file.read
  puts content
ensure
  file.close  # 无论是否出错，这行一定会执行
end