#!/usr/bin/env ruby -w
# frozen_string_literal: true

# 散列。
#
# 参见 {Ruby 内核参考：Literals：Hashes}[https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Hashes]
# 和 {Ruby 内核参考：Hash}[https://ruby-doc.org/core/Hash.html]。
#
# zhengrr
# 2019-12-31 – 2020-07-30
# Unlicense

# 散列字面量。
#
# 优先选用此形式。
_ = { 0 => false, 1 => true }

# 以符号为键的散列字面量。
_ = { key: 'value' } # => { :key => 'value' }
