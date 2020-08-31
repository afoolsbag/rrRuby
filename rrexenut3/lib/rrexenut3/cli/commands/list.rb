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
      map(%w[list ll ls], :list, nil, '列出当日活动')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.list(_args, sess)
        rows = sess.profile.select_activities_by_day(sess.focus_date)

        table = TTY::Table.new(header: %w[时间 描述 名称 剂量])

        rows.each do |row|
          time, description, ifri, amount = row.values
          name, _nutrients = RrExeNut3::Ifrs.query(ifri).values
          table << [time.strftime('%T'), description, name, amount]
        end

        puts table.render(:ascii)
        puts
      end
    end
  end
end
