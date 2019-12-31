#!/usr/bin/env ruby
# coding: utf-8

require 'test/unit'

# 字符串
class TestCaseForString < Test::Unit::TestCase

  # 字符串字面量
  def test_string_literal
    # 单引号字符串不支持插值，且仅支持 \\ 和 \` 转义序列
    s1 = 'string with single quote'

    # 双引号字符串支持插值，并支持以下转义序列：
    #   \\ 反斜线
    #   \" 双引号
    #   \a 告警 alert
    #   \b 退格 backspace
    #   \r 回车 carriage return
    #   \n 换行 newline
    #   \s 空格 space
    #   \t 制表符 tab
    s2 = "string with double quote"
  end

  # 备用引号
  #   对于 Perl 程序员来说 %q 和 %Q 可能更亲切：
  #   %q?...? 等同于 '...'，
  #   %Q?...? 等同于 "..."；
  #   %q 或 %Q 后紧跟的符号叫做界定符，可从标点中任意选取，用于标记字符串的开头和结尾；
  #   若选用匹配的括号作为界定符，则内部可嵌套括号，而不必转义它们。
  def test_alternate_quotes
    s1 = %q'string with alternate single quote'
    s2 = %Q"string with alternate double quote"
  end

  # 继承自 Unix 壳层的 << 操作
  def test_here_documents
    puts(<<-EndOfString1, <<-EndOfString2)
    This is a string with marked as #1.
    EndOfString1
    This is a string with marked as #2.
    EndOfString2
  end

end
