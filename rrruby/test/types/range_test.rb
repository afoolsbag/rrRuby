#!/usr/bin/env ruby
# coding: utf-8

require 'test/unit'

# 范围
class TestCaseForRange < Test::Unit::TestCase

  # 范围字面量
  def test_range_literal
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
