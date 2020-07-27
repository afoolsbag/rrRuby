#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2019-12-31 – 2020-07-27
# Unlicense

require 'test/unit'

module ControlExpressions
  ##
  # +case+ 分支语句。
  #
  class CaseTest < Test::Unit::TestCase
    ##
    # +case-when-else-end+ 分支语句。
    #
    #   case
    #   when <条件>
    #     <代码块>
    #   [when <条件>
    #     <代码块>]
    #   [else
    #     <代码块>]
    #   end
    #
    # 或者
    #
    #   case <表达式>
    #   when <值>
    #     <代码块>
    #   [when <值>
    #     <代码块>]
    #   [else
    #     <代码块>]
    #   end
    def test_case_when_else_end; end
  end
end
