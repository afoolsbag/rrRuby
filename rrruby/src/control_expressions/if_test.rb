#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2019-12-31 – 2020-07-27
# Unlicense

require 'test/unit'

module ControlExpressions
  ##
  # +if+ 分支语句。
  class IfTest < Test::Unit::TestCase
    ##
    # +if-elsif-else-end+ 分支语句。
    #
    #   if <条件>
    #     <代码块>
    #   [elsif <条件>
    #     <代码块>]...
    #   [else
    #     <代码块>]
    #   end
    def test_if_elsif_else_end; end

    ##
    # 表达式的 +if+ 修饰符。
    #
    #   <代码> if <条件>
    def test_if_modifier; end
  end
end
