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
    # 数组。
    #
    # 倾向使用 <tt>a = []</tt> 而非 <tt>a = Array.new</tt> 创建数组。
    def test_array
      a = []
      assert_instance_of(Array, a)
      assert_equal(Object, a.class.superclass)
    end

    ##
    # 数组字面量。
    #--
    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    #++
    def test_array_literal
      a = [false, 1_337, 'abc']

      assert_equal(false, a.first)
      assert_equal('abc', a.last)

      assert_equal(false, a[0])
      assert_equal(1_337, a[1])
      assert_equal('abc', a[2])
      assert_nil(a[3])

      assert_equal('abc', a[-1])
      assert_equal(1_337, a[-2])
      assert_equal(false, a[-3])
      assert_nil(a[-4])
    end

    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength

    ##
    # 单词数组字面量。
    #
    # 倾向使用 <tt>%w</tt> 创建单词数组。
    def test_words_array_literal
      a1 = %w[word1 word2 word3]
      a2 = ['word1', 'word2', 'word3'] # rubocop:disable Style/WordArray
      assert_equal(a2, a1)
    end

    ##
    # 符号数组字面量。
    #
    # 倾向使用 <tt>%i</tt> 创建符号数组。
    def test_symbols_array_literal
      a1 = %i[symbol1 symbol2 symbol3]
      a2 = [:symbol1, :symbol2, :symbol3] # rubocop:disable Style/SymbolArray
      assert_equal(a2, a1)
    end

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
