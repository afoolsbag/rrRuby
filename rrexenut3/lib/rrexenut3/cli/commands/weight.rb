#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-31
# Unlicense

require 'rrexenut3/cli/auxiliary'
require 'rrexenut3/cli/commands/_handlers'
require 'rrexenut3/cli/session'

module RrExeNut3
  module Cli
    module Commands
      map(%w[weight], :weight, '[weight]', '记录或展示体重')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.weight(args, sess)
        case args.length
        when 1
          row = sess.profile.select_recent_weight(sess.focus_date)
          puts "最近记录的体重为 #{row.weight}，记录于 #{row.date}。"
          puts
        when 2
          sess.profile.insert_weight(args[1], sess.focus_date)
          LOGGER.info('体重记录完成。')
          puts
        else
          raise ArgumentError, '该命令需要 0 个或 1 个参数。'
        end
      end
    end
  end
end
