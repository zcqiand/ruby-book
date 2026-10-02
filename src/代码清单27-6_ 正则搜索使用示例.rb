# 查找所有gmail邮箱（不区分大小写）
success, results = manager.regex_search({ email: /@gmail\.com$/i })

# 查找所有以138、139、186开头的手机号
success, results = manager.regex_search({
  phone: /^(138|139|186)/
})

# 查找所有姓王的人（王开头，后面任意字符）
success, results = manager.regex_search({ name: /^王/ })