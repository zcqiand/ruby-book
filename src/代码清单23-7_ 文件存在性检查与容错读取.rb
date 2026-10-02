if File.exist?(filepath)
  # 文件存在，读取它
  JSON.parse(File.read(filepath))
else
  # 文件不存在，返回空数组
  []
end