#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-20 – 2020-07-27
# Unlicense

require 'test/unit'

module Methods
  ##
  # 方法。
  #
  # 最外层方法是 +main+ 对象的方法，如 +puts+ 和 +gets+。
  #
  class MethodTest < Test::Unit::TestCase
    ##
    # 方法声明中的括号是可选的
    #
    def do_nothing
      # do nothing
    end

    ##
    # 方法声明中的括号是可选的
    #
    def do_nothing_with_argument(argument)
      # do nothing
    end

    ##
    # <b>方法调用中的括号</b>
    #
    # 方法调用中的括号是可选。
    #--
    # 下列调用都有效：
    #++
    def test_parentheses_with_method_call
      do_nothing
      do_nothing_with_argument('argument')
    end
  end
end
