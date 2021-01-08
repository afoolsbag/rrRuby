#!/usr/bin/env ruby -w
# frozen_string_literal: true

##
# 字面量：真假值和无值。
#
# 参见 {Booleans and nil}[https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Booleans+and+nil]。
#
# zhengrr
# 2021-01-06 – 2021-01-07
# Unlicense

require 'minitest/autorun'

##
# 真假值和无值的测试。
class BooleansAndNilTest < Minitest::Test
  ##
  # 无值是假的。
  def test_that_nil_is_falsy
    refute(nil)
  end

  ##
  # 假值是假的。
  def test_that_false_is_falsy
    refute(false)
  end

  ##
  # 除此之外都是真的。
  def test_that_others_is_truthy
    assert(true)
    assert(0)
    assert('')
  end
end
