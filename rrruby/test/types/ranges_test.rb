#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2019-12-31 – 2020-07-27
# Unlicense

require 'test/unit'

module Types
  ##
  # 范围
  #
  #   Range < Object
  #
  # 参见 {Ruby 内核参考：Range}[https://ruby-doc.org/core/Range.html]。
  class RangeTest < Test::Unit::TestCase
    ##
    # 范围字面量
    #
    def test_range_literal
      r13 = (1..13)
      r12 = (1...13)
      r26 = 'a'..'z'
      r = 1.0..2.0

      assert_equal(13, r13.count)
      assert_equal(12, r12.count)
      assert_equal(26, r26.count)

      assert_instance_of(Range, r)
      assert_equal(Object, r.class.superclass)
    end

    ##
    # 重复
    #
    def test_times
      (1..10).each do |n|
        print "#{n} "
      end
      10.times do
        print '.'
      end
    end
  end
end