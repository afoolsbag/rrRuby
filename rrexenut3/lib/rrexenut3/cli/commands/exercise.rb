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
      map(%w[do exercise], :exercise, '<exercise_id> <amount> [description]', '运动，录入当日活动')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.exercise(args, sess)
        raise ArgumentError, '该命令需要至少 2 个参数。' if args.length < 3

        sess.record_activity(args[1], args[2], args[3])
      end
    end
  end
end
