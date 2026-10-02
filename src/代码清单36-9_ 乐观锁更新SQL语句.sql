-- Rails 实际执行的 SQL
UPDATE products
SET name = '新名字', lock_version = lock_version + 1
WHERE id = 1 AND lock_version = 3