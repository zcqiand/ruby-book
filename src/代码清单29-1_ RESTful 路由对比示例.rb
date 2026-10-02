# 非 RESTful：URL 包含动词，语义混乱
get '/show_article' do ... end
post '/update_article' do ... end
post '/delete_article' do ... end

# RESTful：URL 是资源，方法是动词，语义自洽
get '/articles/:id' do ... end
put '/articles/:id' do ... end
delete '/articles/:id' do ... end