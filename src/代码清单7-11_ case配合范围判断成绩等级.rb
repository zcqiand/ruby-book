# 判断成绩等级: D(<60), C(60-70), B(70-85), A(>85)
def grade_from_score(score)
  case score
  when 0...60    # 0 <= score < 60
    "D"
  when 60...70   # 60 <= score < 70
    "C"
  when 70...85   # 70 <= score < 85
    "B"
  when 85..100   # 85 <= score <= 100
    "A"
  else
    "无效分数"
  end
end

# 测试各等级边界
test_scores = [45, 60, 70, 85, 100, 105, -5]
test_scores.each do |s|
  puts "分数 #{s.to_s.rjust(3)} -> 等级 #{grade_from_score(s)}"
end