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
      map(%w[load_profile], :load_profile, '<profile_name>', '加载档案')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.load_profile(args, sess)
        raise ArgumentError, '该命令需要至少 1 个参数。' if args.length < 2

        profile_name = args[1]

        sess.load_profile(profile_name)
        puts sess.succ("档案 #{profile_name} 加载完毕。")
        puts
      end

      map(%w[new_profile], :new_profile, '<profile_name>', '新建档案')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.new_profile(args, sess)
        raise ArgumentError, '该命令需要至少 1 个参数。' if args.length < 2

        profile_name = args[1]

        sess.new_profile(profile_name, mode: :new)
        puts sess.succ("档案 #{profile_name} 新建并加载完毕。")
        puts
      end

      map(%w[where], :where, nil, '显示档案路径')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.where(args, sess)
        puts "#{CONFIG.fetch(:load_path)}"
        puts
      end
    end
  end
end
