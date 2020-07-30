#!/usr/bin/env ruby -w
# frozen_string_literal: true

# 数组。
#
# 参见 {Ruby 内核参考：Literals：Arrays}[https://ruby-doc.org/core/doc/syntax/literals_rdoc.html#label-Arrays]
# 和 {Ruby 内核参考：Array}[https://ruby-doc.org/core/Array.html]。
#
# zhengrr
# 2019-12-31 – 2020-07-30
# Unlicense

# 数组字面量。
#
# 优先选用此形式。
_ = [0, 1, 2]

# 数组类构造方法。
#
# 在需要指定数组大小时，选用此形式。
_ = Array.new(3) #=> [nil, nil, nil]

# 公用默认引用的数组类构造方法。
#
# 注意，依此方法生成的数组，由同一对象的引用填充，因而适合用于存放不变对象，如
#
# * 真假值
# * 数字
# * 符号
# * 不变字符串等
#
# 在需要指定数组大小和公用默认引用时，选用此形式。
_ = Array.new(3, true) #=> [true, true, true]

# 私用默认引用的数组类构造方法。
#
# 在需要指定数组大小和私用默认引用时，选用此形式。
#
# 譬如多维数组。
_ = Array.new(2) { Array.new(2) } #=> [[nil, nil], [nil, nil]]

# 单词数组字面量。
#
# 在元素内容都为单词时，选用此形式。
_ = %w[word1 word2 word3] #=> ['word1', 'word2', 'word3']

# 符号数组字面量。
#
# 在元素内容都为符号时，选用此形式。
_ = %i[symbol1 symbol2 symbol3] #=> [:symbol1, :symbol2, :symbol3]

# 数组元素访问。
a = [0, 1, 2]
_ = a.first #=> 0
_ = a[0] #=> 0
_ = a[1] #=> 1
_ = a[2] #=> 2
_ = a[3] #=> nil
_ = a.last #=> 3
_ = a[-1] #=> 2
_ = a[-2] #=> 1
_ = a[-3] #=> 0
_ = a[-4] #=> nil

# 数组切片。
a = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
_ = a[4, 3] #=> [4, 5, 6]
_ = a[4..6] #=> [4, 5, 6]
_ = a[4...7] #=> [4, 5, 6]

r = [-8, -7, -6, -5, -4, -3, -2, -1]
_ = r[-6..-4] #=> [-6, -5, -4]
_ = r[2..-4] #=> [-6, -5, -4]
