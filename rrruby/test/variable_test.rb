#!/usr/bin/env ruby -w
# coding: utf-8

require 'test/unit'

class TC4Variable < Test::Unit::TestCase
  def test_variable
    ref1 = 0
    ref2 = ref1
    assert_equal(ref1.object_id, ref2.object_id)
  end

  def test_parallel_assignment
    var1, var2 = 'loo', 'zoo'
    var1, var2 = var2, var1
    assert_equal('zoo', var1)
    assert_equal('loo', var2)
  end
end
