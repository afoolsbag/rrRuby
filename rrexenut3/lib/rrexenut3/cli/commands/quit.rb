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
      map(%w[close exit quit], :quit, nil, '退出程序')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [Symbol] 循环终止标志
      def self.quit(_args, _sess)
        :break
      end
    end
  end
end
