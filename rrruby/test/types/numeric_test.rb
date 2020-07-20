#!/usr/bin/env ruby
# coding: utf-8
#
# zhengrr
# 2020-01-02 – 2020-07-20
# Unlicense

require 'test/unit'

##
# <b>数字</b>
#
#   Bignum < Integer < Numeric < Object
#   Fixnum < Integer < Numeric < Object
#            Float   < Numeric < Object
#
class NumericTest < Test::Unit::TestCase

  ##
  # <b>数字字面量中的下划线</b>
  #
  # 数字字面量中的下划线将被忽略，因此可以用作位数分隔符。
  #--
  # 下列数字字面量都有效：
  #++
  def test_underscore_with_numeric_literal
    1000000000
    1_000_000_000
  end

end
