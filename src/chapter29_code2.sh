ruby -r ./article.rb -e "
a = Article.create(title: '测试', content: '内容')
puts a.title
a.update(title: '新标题', content: '新内容')
puts a.title
"