#!/usr/bin/env ruby -w
# coding: utf-8

require 'test/unit'

class TC4ArrayHash < Test::Unit::TestCase
  def test_array_literal
    a = [false, 12345, 'str']
    assert_equal(false, a[0])
    assert_equal(12345, a[1])
    assert_equal('str', a[2])
    assert_equal(nil, a[3])
  end

  def test_array_words
    a = %w{one two six}
    assert_equal('one', a[0])
    assert_equal('two', a[1])
    assert_equal('six', a[2])
  end

  def test_subarray
    a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
    assert_equal([4, 5, 6], a[4, 3])
    assert_equal([4, 5, 6], a[4..6])
    assert_equal([4, 5, 6], a[4...7]
    )
    r = [-8, -7, -6, -5, -4, -3, -2, -1]
    assert_equal([-6, -5, -4], r[-6..-4])
    assert_equal([-6, -5, -4], r[2..-4])
  end

  def test_hash_literal
    h = {
        false => 'str',
        12345 => false,
        'str' => 12345
    }
    assert_equal('str', h[false])
    assert_equal(false, h[12345])
    assert_equal(12345, h['str'])
    assert_equal(nil, h[nil])
  end

end
