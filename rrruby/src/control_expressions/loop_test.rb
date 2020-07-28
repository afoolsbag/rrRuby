#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2019-12-31 – 2020-07-27
# Unlicense

require 'test/unit'

module ControlExpressions
  ##
  # +loop+ 循环语句。
  class LoopTest < Test::Unit::TestCase
    ##
    # +loop-do-break-end+ 循环语句。
    #
    #   loop do
    #     <代码块>
    #     break if <条件>
    #   end
    #
    # 为了与 +while+ 修饰区分，Ruby 不提供 +do-while+ 循环，而以 +loop-do-break-end+ 代之。
    def test_loop_do_break_end; end
  end
end
