#!/usr/bin/env ruby -w
# frozen_string_literal: true

# 方法。
#
# 参见 {Ruby 内核参考：Calling Methods}[https://ruby-doc.org/core/doc/syntax/calling_methods_rdoc.html]
# 和 {Ruby 内核参考：Methods}[https://ruby-doc.org/core/doc/syntax/methods_rdoc.html]。
#
# zhengrr
# 2020-07-20 – 2020-07-30
# Unlicense

# 通过向对象传递消息，来调用方法。
#
#   receiver . message_name arguments,...
#
# 默认的接收者是 +self+。最外层的默认接受者是 +main+ 对象，一个特殊的 +Object+ 实例。
p [self.class, self]

# Ruby 中提供三种参数：位置参数，命名参数和块参数。Ruby 中的参数都通过引用传递。

# 位置参数。
#
#   mp1(1)                      #=> ArgumentError
#   mp1(1, 2)                   #=> ArgumentError
#   mp1(1, 2, 3)                #=> [1, 2, 3]
#   mp1(1, 2, 3, 4)             #=> ArgumentError
#   mp1(1, 2, key3: 3, key4: 4) #=> [1, 2, {:key3=>3, :key4=>4}]
def mp1(pos1, pos2, pos3)
  p [pos1, pos2, pos3]
end

# 带默认值的位置参数。
#
#   mp2(1)       #=> ArgumentError
#   mp2(1, 2)    #=> [1, 2, 3]
#   mp2(1, 2, 3) #=> [1, 2, 3]
def mp2(pos1, pos2, opt3 = 3)
  p [pos1, pos2, opt3]
end

# 可增数目的位置参数。
#
#   mp3(1, 2, 3)       #=> [1, 2, 3, []]
#   mp3(1, 2, 3, 4)    #=> [1, 2, 3, [4]]
#   mp3(1, 2, 3, 4, 5) #=> [1, 2, 3, [4, 5]]
def mp3(pos1, pos2, pos3, *rest)
  p [pos1, pos2, pos3, rest]
end

# 命名参数。
#
#   mk1(key1: 1, key2: 2)                   #=> ArgumentError
#   mk1(key1: 1, key2: 2, key3: 3)          #=> [1, 2, 3]
#   mk1(key1: 1, key2: 2, key3: 3, key4: 4) #=> ArgumentError
def mk1(key1:, key2:, key3:)
  p [key1, key2, key3]
end

# 带默认值的命名参数。
#
#   mk2(key1: 1)                   #=> ArgumentError
#   mk2(key1: 1, key2: 2)          #=> [1, 2, 3]
#   mk2(key1: 1, key2: 2, opt3: 3) #=> [1, 2, 3]
def mk2(key1:, key2:, opt3: 3)
  p [key1, key2, opt3]
end

# 可增数目的命名参数。
#
#   mk3(key1: 1, key2: 2, key3: 3)                   #=> [1, 2, 3, {}]
#   mk3(key1: 1, key2: 2, key3: 3, key4: 4)          #=> [1, 2, 3, {:key4=>4}]
#   mk3(key1: 1, key2: 2, key3: 3, key4: 4, key5: 5) #=> [1, 2, 3, {:key4=>4, :key5=>5}]
def mk3(key1:, key2:, key3:, **rest)
  p [key1, key2, key3, rest]
end

# 块参数。
#
#   mb1 { |arguments,...| expressions }
#
#   mb1 do |arguments,...|
#     expressions
#   end
def mb1(&block)
  block.call('arguments,...') if block_given?
end

# 隐式块参数。
#
# 等同于上一方法。
def mb2
  yield('arguments,...') if block_given?
end
