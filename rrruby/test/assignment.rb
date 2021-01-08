#!/usr/bin/env ruby -w
# frozen_string_literal: true

##
# 赋值。
#
# 参见：
# * {Assignment}[https://ruby-doc.org/core/doc/syntax/assignment_rdoc.html]
# * {Pre-defined global variables}[https://ruby-doc.org/core/doc/globals_rdoc.html]
#
# zhengrr
# 2020-07-20 – 2021-01-07
# Unlicense

require 'minitest/autorun'

##
# 赋值的测试。
class AssignmentTest < Minitest::Test
  ##
  # 向左赋值。
  def test_that_assigns_left
    x = 1337
    assert_equal(1337, x)
  end

  ##
  # 向右赋值。
  def test_that_assigns_right
    1337 => x
    assert_equal(1337, x)
  end
end
