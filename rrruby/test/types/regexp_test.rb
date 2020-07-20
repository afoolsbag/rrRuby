#!/usr/bin/env ruby
# coding: utf-8
#
# zhengrr
# 2020-01-02 – 2020-01-02
# Unlicense

require 'test/unit'

##
# 正则表达式
#
#   Regexp < Object
#
class RegexpTest < Test::Unit::TestCase

  ##
  # 正则表达式字面量
  #
  # {Regular Expressions}[https://wikibooks.org/wiki/Ruby_Programming/Syntax/Literals#Regular_Expressions]
  #
  def test_regular_expression
    re = /word_one|word_two/

    assert_match(re, 'word_one')
    assert_not_nil('word_two' =~ re)

    assert_instance_of(Regexp, re)
    assert_equal(Object, re.class.superclass)
  end

end
