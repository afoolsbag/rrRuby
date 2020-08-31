#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-30
# Unlicense

old, $VERBOSE = $VERBOSE, nil
require 'readline'
$VERBOSE = old

require 'rrexenut3/cli/handlers'
require 'rrexenut3/cli/session'

module RrExeNut3
  ##
  # 命令行接口。
  # Command Line Interface.
  module Cli


    ##
    # 执行。
    def self.exec
      # Readline 相关
      Readline.completer_word_break_characters = "\n"
      Readline.completion_proc = proc { |text| commands.grep(/^#{Regexp.escape(text)}/) }
      Readline.completion_append_character = ''

      # 会话相关
      sess = Session.new

      # 自动加载工作目录下，找到的首个档案
      sess.load_first_profile_in_dir

      # 命令行循环
      loop do
        line = Readline.readline("#{sess.prompt_text} #{sess.prompt_sign} ", true)
        args = line.gsub(/\s+/m, ' ').strip.split(' ')
        next if args[0].nil?

        # 命令缩写
        cmd = command_abbreviations[args[0]] || args[0]

        begin
          break if call(cmd, args, sess) == :break
        rescue Exception => e
          logger.fatal(e)
          puts
        end
      end
    end
  end
end
