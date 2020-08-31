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
      map(%w[birthday], :birthday, '[date]', '设定或展示生日')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.birthday(args, sess)
        case args.length
        when 1
          puts "当前设定的生日为 #{sess.profile.birthday}，" \
               "距今（焦点日期）已有 #{sess.age.to('years').to_s('%.2f')}，计 #{sess.age}。"
          puts
        when 2
          sess.profile.birthday = args[1]
          LOGGER.info("已将生日设定为 #{sess.profile.birthday}。")
          puts
        else
          raise ArgumentError, '该命令需要 0 个或 1 个参数。'
        end
      end
    end
  end
end
