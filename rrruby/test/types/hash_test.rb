#!/usr/bin/env ruby
# coding: utf-8
#
# zhengrr
# 2019-12-31 – 2020-01-02
# Unlicense

require 'test/unit'

##
# 散列表 <tt>Hash < Object</tt>
#
# {Hashes}[https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Hashes]
class Tc4Hash < Test::Unit::TestCase

  ##
  # 散列表字面量
  def test_hash_literal
    h = {
        'k1' => 'v1',
        'k2' => 'v2',
        'k3' => 'v3'
    }

    assert_equal('v1', h['k1'])
    assert_equal('v2', h['k2'])
    assert_equal('v3', h['k3'])
    assert_equal(nil, h[nil])

    assert_instance_of(Hash, h)
    assert_equal(Object, h.class.superclass)
  end

end
