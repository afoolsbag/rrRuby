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
      map(%w[delete remove rm], :remove, '<activity>', '从当日移除一项活动')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.remove(args, sess)
        raise NotImplementedError
      end
    end
  end
end
