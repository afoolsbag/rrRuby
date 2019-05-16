#!/usr/bin/env ruby -w
# coding: utf-8

require 'test/unit'

def just_invoke_block_p0
  yield
end

def just_invoke_block_p3
  yield(false, 12345, 'str')
end

def invoke_proc_from_block(&block)
  block.call()
end

class TC4Block < Test::Unit::TestCase
  def test_block_p0
    tmp = just_invoke_block_p0 {'block'}
    assert_equal('block', tmp)
  end

  def test_block_p3
    tmp = just_invoke_block_p3 {|a1, a2, a3| a1.to_s + a2.to_s + a3.to_s}
    assert_equal('false12345str', tmp)
  end

  def test_block_with_do_end
    tmp = just_invoke_block_p3 do |a1, a2, a3|
      a1.to_s + a2.to_s + a3.to_s
    end
    assert_equal('false12345str', tmp)
  end

  def test_proc_from_block
    tmp = invoke_proc_from_block {'block'}
    assert_equal('block', tmp)
  end

end
