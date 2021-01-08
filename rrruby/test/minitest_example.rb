#!/usr/bin/env ruby -w
# frozen_string_literal: true

##
# 参见 https://github.com/seattlerb/minitest#label-Unit+tests 。
#
# zhengrr
# 2020-07-28 – 2021-01-07
# Unlicense

require 'minitest/autorun'

##
# 示例测试类
class Meme
  def i_can_has_cheezburger?
    'OHAI!'
  end

  def will_it_blend?
    'YES!'
  end
end

##
# 示例测试用例
class MemeTest < Minitest::Test
  def setup
    @meme = Meme.new
  end

  def test_that_kitty_can_eat
    assert_equal('OHAI!', @meme.i_can_has_cheezburger?)
  end

  def test_that_it_will_not_blend
    refute_match(/^no/i, @meme.will_it_blend?)
  end

  def test_that_will_be_skipped
    skip('test this later')
  end
end
