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
      map(%w[? help], :help, nil, '帮助')
      ##
      # 帮助信息。
      #
      #   cmd <param1> <param2> <param3> [opt1] [opt2] desc
      #      |<~~~~~~~~~~~~~~~ usage ~~~~~~~~~~~~~~~>||<d>|
      #
      #   cmd <param1>                                 desc
      #      |<usage>||<~~~~ desc_align_padding ~~~~>||<d>|
      #
      #   |<~~~~~~~~~~~~ desc_align_col ~~~~~~~~~~~~>|
      #
      # @param args [Array<String>] 命令行参数
      # @param sess [Session] 命令行会话
      # @return [void]
      def self.help(_args, _sess)
        desc_align_col = 0
        COMMAND_TO_SYMBOL.each do |cmd, sym|
          usage = SYMBOL_TO_USAGE[sym]
          usage = " #{usage}" unless usage.empty?

          cmd_usage_len = cmd.length + usage.length
          desc_align_col = cmd_usage_len if desc_align_col < cmd_usage_len
        end

        puts '当前可以理解的命令有：'
        COMMAND_TO_SYMBOL.sort_by(&:first).to_h.each do |cmd, sym|
          usage = SYMBOL_TO_USAGE[sym]
          usage = " #{usage}" unless usage.empty?
          desc = SYMBOL_TO_DESCRIPTION[sym]
          desc = " #{desc}" unless desc.empty?

          cmd_usage_len = cmd.length + usage.length
          desc_align_padding = ' ' * (desc_align_col - cmd_usage_len)

          c_cmd = PASTEL.white(cmd)

          c_usage = ''
          usage.each_char do |char|
            c_usage +=
              if %w'( ) < > [ ] { }'.include?(char)
                PASTEL.white(char)
              else
                PASTEL.bright_black(char)
              end
          end

          c_desc = PASTEL.bright_black(desc)

          puts "  #{c_cmd}#{c_usage}#{desc_align_padding}#{c_desc}"
        end
        puts
      end
    end
  end
end
