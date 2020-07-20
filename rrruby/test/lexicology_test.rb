#!/usr/bin/env ruby
# coding: utf-8
#
# zhengrr
# 2019-12-31 – 2020-07-20
# Unlicense

require 'test/unit'

##
# <b>词汇</b>
#
# == 标识符
#
# * 命名须符合 <tt>^[A-Z_a-z]+[0-9A-Z_a-z]*$</tt>
# * 没有长度限制
# * 不能与关键字重名
#
# == 注释
#
#   # 这是行注释
#
#   ##
#   # 行注释默认允许 RDoc 处理，但通常将首行叠写留空，以区别于普通注释
#   #
#
#   =begin
#   这是块注释
#   =end
#
#   =begin rdoc
#   这是标记为允许 RDoc 处理的块注释
#   =end
#
# == 保留字
#
#   =begin   =end
#   BEGIN    END
#   __FILE__ __LINE__
#   alias    and
#   begin    break
#   case     class
#   def      defined? do
#   else     elsif    end      ensure
#   false    for
#   if       in
#   module
#   next     nil   not
#   or
#   redo     rescue   retry    return
#   self     super
#   then     true
#   undef    unless   until
#   when     while
#   yield
#
class LexicologyTest < Test::Unit::TestCase
end
