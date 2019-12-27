#!/usr/bin/env ruby -w
# coding: utf-8

# 哈希（表）

require 'test/unit'

class TestCaseForHash < Test::Unit::TestCase

  def test_hash_literal
    # 哈希（表）字面量
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
