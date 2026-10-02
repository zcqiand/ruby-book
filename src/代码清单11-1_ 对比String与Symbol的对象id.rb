# String：每次都是新对象
"hello".object_id  # => 70123456789010
"hello".object_id  # => 70123456789020（不同对象）

# Symbol：所有相同符号共享一个对象
:hello.object_id  # => 80123456789010
:hello.object_id  # => 80123456789010（同一个对象）