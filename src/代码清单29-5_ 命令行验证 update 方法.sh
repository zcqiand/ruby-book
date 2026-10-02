ruby -r ./article.rb -e "
a = Article.create(title: '测试文章', content: '这是内容')
puts \"更新前：#{a.title}\"
a.update(title: '新标题', content: '新内容')
puts \"更新后：#{a.title}\"
"