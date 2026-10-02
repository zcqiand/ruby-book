products = {
  ruby: { name: 'Ruby教程', price: 89, stock: 50 },
  python: { name: 'Python教程', price: 79, stock: 30 },
  javascript: { name: 'JS教程', price: 99, stock: 20 }
}

# select：保留满足条件的键值对
expensive = products.select { |_, info| info[:price] > 80 }
# => {:ruby=>{...}, :javascript=>{...}}

# reject：排除满足条件的键值对
affordable = products.reject { |_, info| info[:price] > 80 }
# => {:python=>{...}}

# 链式调用
premium_coding = products
  .select { |_, info| info[:price] > 80 }
  .transform_values { |v| v[:name] }
# => {:ruby=>'Ruby教程', :javascript=>'JS教程'}