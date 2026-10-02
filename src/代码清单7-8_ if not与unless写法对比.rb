# 用 if not 的写法
def invalid_input?(input)
  if not input.nil? and input != ""
    return false
  else
    return true
  end
end

# 用 unless 的写法
def invalid_input?(input)
  return true unless input
  false
end