#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2019-12-31 – 2020-07-27
# Unlicense

require 'test/unit'

module ControlExpressions
  ##
  # +while+ 循环语句。
  class WhileTest < Test::Unit::TestCase
    ##
    # +while-end+ 循环语句。
    #
    #   while <条件>
    #     <代码块>
    #   end
    def test_while_end; end

    ##
    # 表达式的 +while+ 修饰符。
    #
    #   <代码> while <条件>
    def test_while_modifier; end
  end
end
