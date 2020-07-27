#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-01-02 – 2020-07-27
# Unlicense

require 'test/unit'

module Types
  ##
  # 正则表达式
  #
  #   Regexp < Object
  #
  # 参见 {Ruby 内核参考：Regexp}[https://ruby-doc.org/core/Regexp.html]。
  class RegexpTest < Test::Unit::TestCase
    ##
    # 正则表达式字面量
    def test_regular_expression
      re = /word_one|word_two/

      assert_match(re, 'word_one')
      assert_not_nil('word_two' =~ re)

      assert_instance_of(Regexp, re)
      assert_equal(Object, re.class.superclass)
    end
  end
end
