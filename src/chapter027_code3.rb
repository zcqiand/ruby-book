# 查找姓张且电话以138开头的联系人
success, results = manager.advanced_search({ name: '张', phone: '138' })

# 查找所有gmail邮箱的联系人
success, results = manager.advanced_search({ email: 'gmail' })

# 组合多个条件
success, results = manager.advanced_search({
  name: '王',
  email: 'qq'
})