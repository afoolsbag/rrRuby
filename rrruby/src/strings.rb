#!/usr/bin/env ruby -w
# frozen_string_literal: true

# 字符串。
#
# 参见 {Ruby 内核参考：Literals：Strings}[https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Strings]
# 和 {Ruby 内核参考：String}[https://ruby-doc.org/core/String.html]。
#
# zhengrr
# 2019-12-31 – 2020-07-30
# Unlicense

INTERPOLATION = '#'

# 单引号字符串字面量。
#
# 不支持插值，且仅支持单引号（<tt>\\'</tt>）和反斜杠（<tt>\\\\</tt>）转义字符。
#
# 优先选用此形式。
_ = 'This is a string enclosed in single-quotes.'

# 双引号字符串字面量。
#
# 支持插值和转义字符。
#
# 在需要插值或转义字符时选用此形式。
# 在需要单引号时选用此形式，可以避免转义单引号。
_ = "This is a string containing #{INTERPOLATION}(interpolation)."
_ = "This is a string containing '(single-quote)."

# 单引号字符串的替代形式字面量。
#
# 在需要单、双引号时选用此形式，可以避免转义单、双引号。
_ = %q(This is a string containing '(single-quote) and "(double-quote).)

# 双引号字符串的替代形式字面量。
#
# +%Q(......)+ 可以简化为 +%(......)+。
#
# 在需要插值或转义字符的同时，也需要单、双引号时，选用此形式。
_ = %(This is a string containing #{INTERPOLATION}(interpolation), '(single-quote) and "(double-quote).)

# 嵌入文档字符串字面量。
#
# 可以使用单引号、双引号或反引号将终止标识符括起，其行为与对应字符串类似：
#
#   <<'EOF'
#   ......
#   EOF
#
#   <<"EOF"
#   ......
#   EOF
#
#   <<`EOF`
#   ......
#   EOF
#
# 可以在 +<<+ 后接 +-+ 或 +~+ 符号，+-+ 允许标识符缩进，+~+ 允许标识符和内容都缩进：
#
#   begin
#     <<-EOF
#   ......
#   EOF
#   end
#
#   begin
#     <<-EOF
#   ......
#     EOF
#   end
#
#   begin
#     <<~EOF
#       ......
#     EOF
#   end
#
# 在需要大量文本时，选用此形式。
_, _ = <<~END_OF_HEREDOC, <<~END_OF_ANOTHER_HEREDOC # rubocop:disable Style/ParallelAssignment, Style/TrailingUnderscoreVariable
  This is a string enclosed in here-document.
END_OF_HEREDOC
  This is a another string enclosed in here-document.
END_OF_ANOTHER_HEREDOC
