#!/usr/bin/env ruby -w
# coding: utf-8

# 范围

require 'test/unit'

class TestCaseForRange < Test::Unit::TestCase

  def test_range_literal
    # 范围字面量
    assert_equal(10, (1..10).count)
    assert_equal(9, (1...10).count)
    assert_equal(26, ('a'..'z').count)

    (1..10).each do |n|
      print "#{n} "
    end

    10.times do
      print '.'
    end
  end

end
