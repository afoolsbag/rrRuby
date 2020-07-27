#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2019-12-31 – 2020-07-27
# Unlicense

require 'test/unit'

module Types
  ##
  # 散列表。
  #
  #   Hash < Object
  #
  # 参见 {Ruby 内核参考：Hash}[https://ruby-doc.org/core/Hash.html]。
  class HashTest < Test::Unit::TestCase
    ##
    # 散列表类型。
    def test_hash_type
      h = {}
      assert_instance_of(Hash, h)
      assert_equal(Object, h.class.superclass)
    end

    ##
    # 散列表字面量。
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
    end

    ##
    # 以符号为键的散列表字面量。
    def test_hash_literal_with_symbol
      h = {
        k1: 'v1',
        k2: 'v2',
        k3: 'v3'
      }

      assert_equal('v1', h[:k1])
      assert_equal('v2', h[:k2])
      assert_equal('v3', h[:k3])
      assert_equal(nil, h[nil])
    end
  end
end
