require 'json'

# Ruby对象转JSON字符串
array = [{name: "Alice", age: 30}, {name: "Bob", age: 25}]
json_string = JSON.generate(array)
# => "[{\"name\":\"Alice\",\"age\":30},{\"name\":\"Bob\",\"age\":25}]"

# JSON字符串转Ruby对象
parsed = JSON.parse(json_string)
# => [{"name"=>"Alice", "age"=>30}, {"name"=>"Bob", "age"=>25}]