#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-09-02
# Unlicense

require 'rrexenut3/cli/commands/_handlers'
require 'rrexenut3/cli/session'
require 'rrexenut3/cn_dris_2013/dris'

module RrExeNut3
  module Cli
    module Commands
      map(%w[sex], :sex, '[sex]', '记录性别、孕期或哺乳期')
      ##
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.sex(args, sess)
        case args.length
        when 1
          row = sess.profile.select_recent_sex(sess.focus_date)
          puts "最近记录的性别、孕期或哺乳期为 #{row.sex}，记录于 #{row.date}。"
          puts
        when 2
          sex = args[1].to_sym
          raise "值 #{sex} 不是有效的参数。" unless CnDris2013::Dris::SEX_VALID_VALUES.include?(sex)

          sess.profile.insert_sex(sex, sess.focus_date)
          LOGGER.success('性别、孕期或哺乳期记录完成。')
          puts
        else
          raise ArgumentError, '该命令需要 0 个或 1 个参数。'
        end
      end
    end
  end
end
