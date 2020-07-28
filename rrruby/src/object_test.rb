#!/usr/bin/env ruby
# frozen_string_literal: true

# zhengrr
# 2020-07-28 – 2020-07-28
# Unlicense

require 'test/unit'

##
# Ruby 是一种面向对象语言，Ruby 中的一切都是对象。
class ObjectTest < Test::Unit::TestCase
  ##
  # 创建对象。
  #
  # 类（class）是变量（variable）和方法（method）的组合，对象（object）是类的实例（instance）。
  #
  # Ruby 通过调用类的构造函数（constructor）来创建对象，标准构造函数被称为 +new+。
  def test_object_new
    obj = Object.new # rubocop:disable Lint/UselessAssignment
  end

  ##
  # 调用方法。
  #
  # Ruby 通过向对象发送消息（message）来调用方法：
  #
  #   receiver . method_name method_arguments,...
  #
  # 更常见的形式：
  #
  #   receiver.method_name
  #   receiver.method_name(method_arguments,...)
  #
  # 若未指定接收者，则其默认为 +self+。
  def test_object_message; end

  ##
  # 对象标识符。
  #
  # Ruby 中每个对象都有一个唯一的对象标识符，通过 +object_id+ 方法获取。
  def test_object_identifier
    o1 = Object.new
    o2 = Object.new
    assert_not_equal(o1.object_id, o2.object_id)
  end
end
