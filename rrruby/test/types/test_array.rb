#!/usr/bin/env ruby -w
# coding: utf-8

# 数组

require 'test/unit'

class TestCaseForArray < Test::Unit::TestCase

  def test_array_literal
    # 数组字面量
    a = [false, 12345, 'str']
    assert_equal(false, a[0])
    assert_equal(12345, a[1])
    assert_equal('str', a[2])
    assert_equal(nil, a[3])
  end

  def test_array_words
    # 单词数组
    wl = %w{foo bar baz #{1+1}}
    assert_equal('foo', wl[0])
    assert_equal('bar', wl[1])
    assert_equal('baz', wl[2])
    assert_equal('#{1+1}', wl[3])
    wu = %W{foo bar baz #{1 + 1}}
    assert_equal('foo', wu[0])
    assert_equal('bar', wu[1])
    assert_equal('baz', wu[2])
    assert_equal('2', wu[3])
  end

  def test_subarray
    # 子数组（数组切片）
    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert_equal([4, 5, 6], a[4, 3])
    assert_equal([4, 5, 6], a[4..6])
    assert_equal([4, 5, 6], a[4...7])
    r = [-8, -7, -6, -5, -4, -3, -2, -1]
    assert_equal([-6, -5, -4], r[-6..-4])
    assert_equal([-6, -5, -4], r[2..-4])
  end

end
