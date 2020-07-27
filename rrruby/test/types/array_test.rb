#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2019-12-31 – 2020-07-27
# Unlicense

require 'test/unit'

module Types
  ##
  # 数组。
  #
  #   Array < Object
  #
  # 参见 {Ruby 内核参考：Array}[https://ruby-doc.org/core/Array.html]。
  class ArrayTest < Test::Unit::TestCase
    ##
    # 数组类型。
    def test_array_type
      a = []
      assert_instance_of(Array, a)
      assert_equal(Object, a.class.superclass)
    end

    ##
    # 数组字面量。
    def test_array_literal
      a = [false, 123_5, 'str']

      assert_equal(false, a[0])
      assert_equal(123_5, a[1])
      assert_equal('str', a[2])
      assert_equal(nil, a[3])
    end

    ##
    # 符号数组。
    def test_array_of_symbols
      # 非插值符号数组
      _ = %i[]

      # 插值符号数组
      _ = %I[]
    end

    ##
    # 单词数组。
    #--
    # rubocop:disable Metrics/AbcSize
    #++
    def test_array_of_words
      # 非插值单词数组
      w1 = %w[foo bar baz #{1+1}] # rubocop:disable Lint/InterpolationCheck
      assert_equal('foo', w1[0])
      assert_equal('bar', w1[1])
      assert_equal('baz', w1[2])
      assert_equal('#{1+1}', w1[3]) # rubocop:disable Lint/InterpolationCheck

      # 插值单词数组
      w2 = %W[foo bar baz #{1 + 1}]
      assert_equal('foo', w2[0])
      assert_equal('bar', w2[1])
      assert_equal('baz', w2[2])
      assert_equal('2', w2[3])
    end
    # rubocop:enable Metrics/AbcSize

    ##
    # 子数组（数组切片）。
    def test_subarray
      a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
      assert_equal([4, 5, 6], a[4, 3])
      assert_equal([4, 5, 6], a[4..6])
      assert_equal([4, 5, 6], a[4...7])

      r = [-8, -7, -6, -5, -4, -3, -2, -1]
      assert_equal([-6, -5, -4], r[-6..-4])
      assert_equal([-6, -5, -4], r[2..-4])
    end
  end
end
