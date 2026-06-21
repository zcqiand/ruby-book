csv = "Ruby,Python,Go"
langs = csv.split(",")
puts langs.join(" | ")
text = "apple,banana,,cherry,"
fruits = text.split(",").reject(&:empty?)
puts fruits
# 预期输出：
# Ruby | Python | Go
# apple
# banana
# cherry