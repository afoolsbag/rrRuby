#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-31
# Unlicense

require 'rrexenut3/cli/commands/_handlers'
require 'rrexenut3/cli/session'

module RrExeNut3
  module Cli
    module Commands
      map(%w[clear cls], :clear, nil, '清空屏幕')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.clear(_args, _sess)
        # Console Virtual Terminal Sequences
        # ESC 2 J 清屏
        # ESC [ F 将光标移至首行开头
        print "\e[2J\e[F"
      end
    end
  end
end
