#!/usr/bin/env ruby
# coding: utf-8
#
# zhengrr
# 2019-12-31 – 2020-01-02
# Unlicense

require 'test/unit'

##
# 哈希（表）
#
#   Hash < Object
#
class TestCaseForHash < Test::Unit::TestCase

  ##
  # 哈希（表）字面量
  #
  # {Hashes}[https://wikibooks.org/wiki/Ruby_Programming/Syntax/Literals#Hashes]
  #
  def test_hash_literal
    h = {false => 'str', 12345 => false, 'str' => 12345}

    assert_equal('str', h[false])
    assert_equal(false, h[12345])
    assert_equal(12345, h['str'])
    assert_equal(nil, h[nil])

    assert_instance_of(Hash, h)
    assert_equal(Object, h.class.superclass)
  end

end
