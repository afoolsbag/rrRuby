#!/usr/bin/env ruby -w
# frozen_string_literal: true

# 控制表达式。
#
# 参见 {Ruby 内核参考：Control Expressions}[https://ruby-doc.org/core/doc/syntax/control_expressions_rdoc.html]。
#
# zhengrr
# 2019-12-31 – 2020-07-30
# Unlicense

def condition
  [true, false].sample
end

# 如果。
#
# +if+ 表达式：
#
#   if <条件> [then]
#     <代码块>
#   [elsif <条件> [then]
#     <代码块>]...
#   [else
#     <代码块>]
#   end
#
# 三元 +if+：
#
#   <条件> ? <为真时的表达式> : <为假时的表达式>
#
# +if+ 修饰符：
#
#   <代码> if <条件>
_ = if condition
      'true'
    else
      'false'
    end

# 除非。
#
# +unless+ 表达式：
#
#   unless <条件> [then]
#     <代码块>
#   [else
#     <代码块>]
#   end
#
# +unless+ 修饰符：
#
#   <代码> unless <条件>
_ = 'false' unless condition

# 案例。
#
# +case+ 表达式：
#
#   case
#   when <条件>
#     <代码块>
#   [when <条件>
#     <代码块>]
#   [else
#     <代码块>]
#   end
#
# 或
#
#   case <表达式>
#   when <值>
#     <代码块>
#   [when <值>
#     <代码块>]
#   [else
#     <代码块>]
#   end
_ = case condition
    when true
      'true'
    when false
      'false'
    else
      '?'
    end

# 当时。
#
# +while+ 循环：
#
#   while <条件>
#     <代码块>
#   end
#
# +while+ 修饰符：
#
#   <代码> while <条件>
while condition
  # ......
end

# 直到。
#
# +until+ 循环：
#
#   until <条件>
#     <代码块>
#   end
#
# +until+ 修饰符：
#
#   <代码> until <条件>
until condition
  # ......
end

# 迭代。
#
# 不要使用 +for+ 循环，使用 +.each+ 方法。

# 后置条件和无限循环。
loop do
  # ......
  break if condition
end
