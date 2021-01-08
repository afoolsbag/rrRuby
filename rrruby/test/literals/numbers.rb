#!/usr/bin/env ruby -w
# frozen_string_literal: true

##
# 字面量：数字。
#
# 参见 {Numbers}[https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Numbers]。
#
# zhengrr
# 2021-01-06 – 2021-01-07
# Unlicense

require 'minitest/autorun'

##
# 数字的测试。
#
# 参见 {Numeric}[https://ruby-doc.org/core/Numeric.html]。
class NumbersTest < Minitest::Test
  ##
  # 整数。
  #
  # 参见 {Integer}[https://ruby-doc.org/core/Integer.html]。
  def test_that_integer
    assert_instance_of(Integer, 1_000)
  end

  ##
  # 进制。
  def test_that_positional
    assert_instance_of(Integer, 0xFF)
    assert_instance_of(Integer, 0d99) # rubocop:disable Style/NumericLiteralPrefix
    assert_instance_of(Integer, 0o77)
    assert_instance_of(Integer, 0b11)
  end

  ##
  # 有理数。
  #
  # 参见 {Rational}[https://ruby-doc.org/core/Rational.html]。
  def test_that_rational
    assert_instance_of(Rational, 1 / 3r)
  end

  ##
  # 浮点数。
  #
  # 参见 {Float}[https://ruby-doc.org/core/Float.html]。
  def test_that_float
    assert_instance_of(Float, 1.0)
  end

  ##
  # 复数。
  #
  # 参见 {Complex}[https://ruby-doc.org/core/Complex.html]。
  def test_that_complex
    assert_instance_of(Complex, 1 + 1i)
  end
end
