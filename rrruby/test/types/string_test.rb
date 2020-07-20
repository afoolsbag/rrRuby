#!/usr/bin/env ruby
# coding: utf-8
#
# zhengrr
# 2019-12-31 – 2020-07-20
# Unlicense

require 'test/unit'

##
# 字符串
#
class StringTest < Test::Unit::TestCase

  ##
  # <b>字符串字面量</b>
  #
  # 单引号字符串不支持插值，且仅支持 <code>\\\\</code> 和 <code>\`</code> 转义序列：
  #
  #   'string with single quote'
  #
  # 双引号字符串支持插值，并支持以下转义序列：
  # * <code>\\\\</code> 反斜线
  # * <code>\"</code> 双引号
  # * <code>\a</code> 告警 alert
  # * <code>\b</code> 退格 backspace
  # * <code>\r</code> 回车 carriage return
  # * <code>\n</code> 换行 newline
  # * <code>\s</code> 空格 space
  # * <code>\t</code> 制表符 tab
  #
  #   "string with double quote"
  #
  def test_string_literal
    s = 'string'

    assert_instance_of(String, s)
    assert_equal(Object, s.class.superclass)
  end

  ##
  # <b>备用引号</b>
  #
  # 对于 Perl 程序员来说 <code>%q</code> 和 <code>%Q</code> 可能更亲切：
  # <code>%q?...?</code> 等同于 <code>'...'</code>，
  # <code>%Q?...?</code> 等同于 <code>"..."</code>；
  # <code>%q</code> 或 <code>%Q</code> 后紧跟的符号叫做界定符，可从标点中任意选取，用于标记字符串的开头和结尾；
  # 若选用匹配的括号作为界定符，则内部可嵌套括号，而不必转义它们。
  #
  def test_alternate_quotes
    s1 = %q'string with alternate single quote'
    s2 = %Q"string with alternate double quote"
  end

  ##
  # 继承自 Unix 壳层的 << 操作
  #
  def test_here_documents
    puts(<<-EndOfString1, <<-EndOfString2)
    This is a string with marked as #1.
    EndOfString1
    This is a string with marked as #2.
    EndOfString2
  end

end
