#!/usr/bin/env ruby
# coding: utf-8

require 'test/unit'

# 哈希（表）
class TestCaseForHash < Test::Unit::TestCase

  # 哈希（表）字面量
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

    h2 = {
        a: 1,
        b: 2
    }
  end

end
