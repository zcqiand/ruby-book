# app.rb — Sinatra 博客主应用
# 本章先搭建路由骨架，具体实现（模板、数据存储）在后续章节完善

require 'sinatra'
require 'json'
require_relative 'article'

# 配置：设置视图模板目录
# 为什么要单独设置：让视图文件与代码分离，符合 MVC 架构思想
set :views, File.join(File.dirname(__FILE__), 'views')

# ============================================================
# 路由：文章列表
# ============================================================
get '/articles' do
  # 获取所有文章，传递给视图
  @articles = Article.all
  # 渲染视图（Sinatra 会自动查找 views/index.erb）
  erb :index
end

# ============================================================
# 路由：查看单篇文章
# ============================================================
get '/articles/:id' do
  # params 是 Sinatra 注入的哈希，包含 URL 参数和查询字符串
  @article = Article.find(params[:id].to_i)
  
  if @article
    erb :show
  else
    # 404 是标准的 HTTP 状态码，表示「页面不存在」
    status 404
    "文章不存在 (ID: #{params[:id]})"
  end
end

# ============================================================
# 路由：新建文章表单
# ============================================================
get '/articles/new' do
  erb :new
end

# ============================================================
# 路由：创建文章（POST 表单提交）
# ============================================================
post '/articles' do
  # params 包含表单中所有字段（name 属性对应键）
  article = Article.create(
    title: params[:title],
    content: params[:content]
  )
  
  # 创建成功后重定向到文章详情页
  # 为什么用 redirect：避免用户刷新页面时重复提交表单
  redirect "/articles/#{article.id}"
end

# ============================================================
# 路由：编辑文章表单
# ============================================================
get '/articles/:id/edit' do
  @article = Article.find(params[:id].to_i)
  
  if @article
    erb :edit
  else
    status 404
    "文章不存在 (ID: #{params[:id]})"
  end
end

# ============================================================
# 路由：更新文章
# Sinatra 不直接支持 PUT/DELETE，通过隐藏字段 _method 模拟
# ============================================================
put '/articles/:id' do
  article = Article.find(params[:id].to_i)
  
  if article
    # 更新文章属性（注意：Article 类需要添加 update 方法）
    article.title = params[:title]
    article.content = params[:content]
    redirect "/articles/#{article.id}"
  else
    status 404
    "文章不存在 (ID: #{params[:id]})"
  end
end

# ============================================================
# 路由：删除文章
# ============================================================
delete '/articles/:id' do
  deleted = Article.delete(params[:id].to_i)
  
  if deleted
    redirect '/articles'
  else
    status 404
    "文章不存在 (ID: #{params[:id]})"
  end
end

# ============================================================
# 首页路由（博客入口）
# ============================================================
get '/' do
  redirect '/articles'
end

# 启动服务器
if __FILE__ == $0
  puts "博客项目已启动，访问 http://localhost:4567/"
  run!
end