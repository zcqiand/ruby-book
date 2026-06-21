   # 这种代码容易忘记更新计数器，导致无限循环
   n = 1
   while n <= 100
     puts n
     # 忘记 n += 1
   end