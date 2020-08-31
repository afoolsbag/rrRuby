#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-31
# Unlicense

old, $VERBOSE = $VERBOSE, nil
require 'readline'
$VERBOSE = old

require 'rrexenut3/cli/commands'
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
      Readline.completion_proc = proc { |text| Commands::COMMANDS.grep(/^#{Regexp.escape(text)}/) }
      Readline.completion_append_character = ''

      # 会话相关
      sess = Session.new
      sess.load_profile_via_configuration unless sess.profile?
      sess.load_first_profile_in_directory unless sess.profile?

      # 命令行循环
      loop do
        line = Readline.readline("#{sess.prompt} ", true)
        args = line.gsub(/\s+/m, ' ').strip.split(' ')
        next if args[0].nil?

        cmd = Commands.unabridge(args[0])

        begin
          break if Commands.call(cmd, args, sess) == :break
        rescue NotImplementedError, StandardError => e
          LOGGER.error(e)
          puts
        end
      end
    end
  end
end
