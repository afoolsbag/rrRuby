#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-01-02 – 2020-07-27
# Unlicense

require 'test/unit'

module Types
  ##
  # 数字。
  #
  #   Bignum < Integer < Numeric < Object
  #   Fixnum < Integer < Numeric < Object
  #            Float   < Numeric < Object
  #
  # 参见 {Ruby 内核参考：Numeric}[https://ruby-doc.org/core/Numeric.html]，
  # {Ruby 内核参考：Integer}[https://ruby-doc.org/core/Integer.html] 和
  # {Ruby 内核参考：Float}[https://ruby-doc.org/core/Float.html]。
  class NumericTest < Test::Unit::TestCase
    ##
    # 数字字面量中的下划线将被忽略，因此可以用作位数分隔符。
    #--
    # 下列数字字面量都有效：
    #++
    def test_numeric_literal_underscore
      _ = 1000000000 # rubocop:disable Style/NumericLiterals
      _ = 1_000_000_000
    end
  end
end
