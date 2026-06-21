# 方式一：查询时直接加锁
product = Product.lock.find(product_id)

# 方式二：先查出数据，再加锁
product = Product.find(product_id)
product.lock!