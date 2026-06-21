# Rails 路由中的 Symbol
get '/users', to: 'users#index'

# Rails 参数中的 Symbol
params[:id]      # 获取 URL 参数
session[:user_id] # 操作 session

# 哈希字面量的 Symbol 简写（Rails 处处可见）
{ name: 'Alice', age: 30 }   # 等价于 { :name => 'Alice', :age => 30 }