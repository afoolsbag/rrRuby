#!/usr/bin/env ruby
# frozen_string_literal: true

# 类。
#
# 参见 {Ruby 内核参考：Modules and Classes}[https://ruby-doc.org/core/doc/syntax/modules_and_classes_rdoc.html]。
#
# zhengrr
# 2020-04-29 – 2020-07-30
# Unlicense

require 'test/unit'

##
# 朴素的类。
class Class
  def initialize(readable_attribute, writable_attribute, accessible_attribute)
    super()
    @readable_attribute = readable_attribute
    @writable_attribute = writable_attribute
    @accessible_attribute = accessible_attribute
  end

  ##
  # 属性读取器，等同于定义了以下方法：
  #
  #   def readable_attribute()
  #     return @readable_attribute
  #   end
  attr_reader :readable_attribute

  ##
  # 属性写入器，等同于定义了以下方法：
  #
  #   def writeable_attribute=(value)
  #     @writable_attribute = value
  #   end
  attr_writer :writable_attribute

  ##
  # 属性访问器，等同于定义了以下方法：
  #
  #  def accessible_attribute()
  #    return @accessible_attribute
  #  end
  #
  #  def accessible_attribute=(value)
  #    @accessible_attribute = value
  #  end
  attr_accessor :accessible_attribute
end
