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
      map(%w[change], :change, '<date>', '切换到某一天')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.change(args, sess)
        raise ArgumentError, '该命令需要且仅需要 1 个参数。' if args.length != 2

        sess.focus_date = args[1]

        LOGGER.info("焦点日期已切换到 #{sess.focus_date}。")
        puts
      end

      map(%w[> next], :next, nil, '切换到后一天')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.next(_args, sess)
        sess.focus_date = sess.focus_date.next_day

        LOGGER.info("焦点日期已切换到 #{sess.focus_date}。")
        puts
      end

      map(%w[< previous], :previous, nil, '切换到前一天')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.previous(_args, sess)
        sess.focus_date = sess.focus_date.prev_day

        LOGGER.info("焦点日期已切换到 #{sess.focus_date}。")
        puts
      end

      map(%w[= today], :today, nil, '切换到今天')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.today(_args, sess)
        sess.focus_date = Date.today

        LOGGER.info("焦点日期已切换到 #{sess.focus_date}。")
        puts
      end
    end
  end
end
