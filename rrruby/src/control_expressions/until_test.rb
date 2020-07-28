#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2019-12-31 – 2020-07-27
# Unlicense

require 'test/unit'

module ControlExpressions
  ##
  # +until+ 循环语句。
  class UntilTest < Test::Unit::TestCase
    ##
    # +until-end+ 循环语句。
    #
    #   until <条件>
    #     <代码块>
    #   end
    def test_until_end; end

    ##
    # 表达式的 +until+ 修饰符。
    #
    #   <代码> until <条件>
    def test_until_modifier; end
  end
end
