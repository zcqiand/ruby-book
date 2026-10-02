# app.rb — Sinatra 博客完整 CRUD 路由
# Sinatra 4.x 兼容语法，无 deprecated API 警告

require 'sinatra'
require 'json'
require_relative 'article'

# 配置视图模板目录
set :views, File.join(File.dirname(__FILE__), 'views')

# 启用 session（Flash 消息依赖 session 存储）
enable :sessions

# Rack::MethodOverride 中间件：将 POST 请求中的 _method 参数转换为对应 HTTP 方法
# 这样表单可以通过隐藏字段发送 PUT/DELETE 请求
use Rack::MethodOverride

# ============================================================
# Flash 消息辅助方法
# Flash 消息：在一次重定向之间传递临时提示信息
# ============================================================
def flash(type)
  # 读取消息后立即清除，刷新页面后消息消失
  message = session[:flash] && session[:flash][type]
  session[:flash] = nil if session[:flash]
  message
end

def set_flash(type, message)
  session[:flash] ||= {}
  session[:flash][type] = message
end

# ============================================================
# READ — 文章列表
# ============================================================
get '/articles' do
  @articles = Article.all
  erb :index
end

# ============================================================
# READ — 单篇文章
# ============================================================
get '/articles/:id' do
  @article = Article.find(params[:id].to_i)

  if @article
    erb :show
  else
    status 404
    erb :not_found
  end
end

# ============================================================
# CREATE — 新建文章表单
# ============================================================
get '/articles/new' do
  erb :new
end

# ============================================================
# CREATE — 处理创建请求
# ============================================================
post '/articles' do
  article = Article.create(
    title: params[:title],
    content: params[:content]
  )

  set_flash(:success, "文章「#{article.title}」创建成功！")
  redirect "/articles/#{article.id}"
end

# ============================================================
# UPDATE — 编辑文章表单
# ============================================================
get '/articles/:id/edit' do
  @article = Article.find(params[:id].to_i)

  if @article
    erb :edit
  else
    status 404
    erb :not_found
  end
end

# ============================================================
# UPDATE — 处理更新请求（PUT via _method hidden field）
# ============================================================
put '/articles/:id' do
  article = Article.find(params[:id].to_i)

  if article
    article.update(
      title: params[:title],
      content: params[:content]
    )
    set_flash(:success, "文章「#{article.title}」更新成功！")
    redirect "/articles/#{article.id}"
  else
    status 404
    erb :not_found
  end
end

# ============================================================
# DELETE — 处理删除请求
# ============================================================
delete '/articles/:id' do
  deleted = Article.delete(params[:id].to_i)

  if deleted
    set_flash(:success, "文章「#{deleted.title}」已删除。")
    redirect '/articles'
  else
    status 404
    erb :not_found
  end
end

# ============================================================
# 首页重定向到文章列表
# ============================================================
get '/' do
  redirect '/articles'
end

# 启动服务器
if __FILE__ == $0
  puts "博客已启动，访问 http://localhost:4567/"
  run!
end