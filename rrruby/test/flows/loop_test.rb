#!/usr/bin/env ruby
# coding: utf-8
#
# zhengrr
# 2019-12-31 – 2020-01-02
# Unlicense

require 'test/unit'

##
# 循环
#
# {Loops}[https://wikibooks.org/wiki/Ruby_Programming/Syntax/Control_Structures#Loops]
#
class TestCaseForLoop < Test::Unit::TestCase

  ##
  # +while-end+ 循环语句
  #
  #   while <条件>
  #     <代码块>
  #   end
  #
  def test_while_end
    i = 0
    while [true, false].sample
      i += 1
    end
    puts "loop #{i} times"
  end

  ##
  # 对于单行代码，建议使用 +while+ 修饰语法
  #
  #   <代码> while <条件>
  #
  def test_while_modifier
    i = 0
    i += 1 while [true, false].sample
    puts "loop #{i} times"
  end

  ##
  # +until-end+ 循环语句
  #
  #   until <条件>
  #     <代码块>
  #   end
  #
  def test_until_end
    i = 0
    until [true, false].sample
      i += 1
    end
    puts "loop #{i} times"
  end

  ##
  # 对于单行代码，建议使用 +until+ 修饰语法
  #
  #   <代码> until <条件>
  #
  def test_until_modifier
    i = 0
    i += 1 until [true, false].sample
    puts "loop #{i} times"
  end

  ##
  # +loop-do-break-end+ 循环语句
  #
  # 为了与 +while+ 修饰区分，Ruby 不提供 +do-while+ 循环，而以 +loop-do-break-end+ 代之
  #
  def test_loop_do_break_end
    i = 0
    loop do
      i += 1
      break if [true, false].sample
    end
    puts "loop #{i} times"
  end

end
