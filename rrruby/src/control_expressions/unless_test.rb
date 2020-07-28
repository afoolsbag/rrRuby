#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2019-12-31 – 2020-07-27
# Unlicense

require 'test/unit'

module ControlExpressions
  ##
  # +unless+ 分支语句。
  class UnlessTest < Test::Unit::TestCase
    ##
    # +unless-else-end+ 分支语句。
    #
    #   unless <条件>
    #     <代码块>
    #   [else
    #     <代码块>]
    #   end
    def test_unless_else_end; end

    ##
    # 表达式的 +unless+ 修饰符。
    #
    #   <代码> unless <条件>
    def test_unless_modifier; end
  end
end
