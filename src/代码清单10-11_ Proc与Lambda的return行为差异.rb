def test_proc
  my_proc = Proc.new { return }
  my_proc.call
  puts "这句不会执行"
end

def test_lambda
  my_lambda = -> { return }
  my_lambda.call
  puts "这句会执行"
end

test_proc    # 方法直接结束
test_lambda # 方法继续执行