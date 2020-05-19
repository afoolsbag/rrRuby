#!/usr/bin/env ruby
# coding: utf-8
#
# zhengrr
# 2020-04-29 – 2020-04-29
# Unlicense

# 对象属性

require 'test/unit'

##
# 最佳形式
#
class Clazz
  def initialize(readable_attribute, writable_attribute, accessible_attribute)
    super()
    @readable_attribute = readable_attribute
    @writable_attribute = writable_attribute
    @accessible_attribute = accessible_attribute
  end

  attr_reader :readable_attribute
  attr_writer :writable_attribute
  attr_accessor :accessible_attribute
end

##
# 最繁形式
#
class Clazz2 < Object # 直接继承自 Object 的类的基类声明可以省略
  def initialize(readable_attribute, writable_attribute, accessible_attribute)
    super();
    @readable_attribute = readable_attribute;
    @writable_attribute = writable_attribute;
    @accessible_attribute = accessible_attribute;
  end

  def readable_attribute() # 可读属性可以使用 attr_reader(*several_variants) 动态生成
    return @readable_attribute;
  end

  def writeable_attribute=(value) # 可写属性可以使用 attr_writer 动态生成
    @writable_attribute = value;
  end

  def accessible_attribute() # 可读写属性可以使用 attr_accessor 动态生成
    return @accessible_attribute;
  end

  def accessible_attribute=(value)
    @accessible_attribute = value;
  end
end
