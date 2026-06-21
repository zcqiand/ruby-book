def prime?(n)
  return false if n < 2
  return true if n == 2
  return false if n.even?
  
  # 只需检查到 sqrt(n)
  3.step(Math.sqrt(n).to_i, 2) do |i|
    return false if n % i == 0
  end
  true
end

# 找出 1-100 的所有素数
primes = []
(2..100).each do |n|
  primes << n if prime?(n)
end

puts "1-100 的素数: #{primes.join(', ')}"
puts "共 #{primes.length} 个素数"