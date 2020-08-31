#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-31
# Unlicense

old, $VERBOSE = $VERBOSE, nil
require 'pastel'
require 'tty-command'
require 'tty-config'
require 'tty-logger'
require 'tty-platform'
$VERBOSE = old

module RrExeNut3
  module Cli
    # @return [TTY::Command]
    COMMAND = TTY::Command.new

    # @return [TTY::Config]
    CONFIG = TTY::Config.new
    CONFIG.filename = 'rrexenut3'

    # @return [TTY::Logger]
    LOGGER = TTY::Logger.new

    # @return [Pastel::Delegator]
    PASTEL = Pastel.new

    # @return [TTY::Platform]
    PLATFORM = TTY::Platform.new

    ##
    # 备份文件。
    #
    #   abc.ext -> abc.ext
    #   .          abc.ext.~20200828T091737000
    #
    # @param path [String, #to_s] 文件路径
    # @param max_count [Fixnum] 最大保留数
    # @param silent [Boolean] 静默，出现异常时返回而不抛出
    def self.backup_file(path, max_count: 3, silent: true)
      path = path.to_s unless path.is_a?(String)
      path = File.absolute_path(path) unless File.absolute_path?(path)

      unless File.file?(path)
        raise "欲备份的文件不存在 #{path}" unless silent

        return
      end

      old_backups = []
      Dir.glob("#{path}.~*") { |old_backup| old_backups.append(old_backup) }
      old_backups.sort!.reverse!
      FileUtils.remove_file(old_backups.pop) while old_backups.length >= max_count

      new_backup = "#{path}.~#{DateTime.now.strftime('%Y%m%dT%H%M%S%3N')}"
      FileUtils.cp(path, new_backup)

      # COMMAND.run('ATTRIB', '+H', new_backup) if PLATFORM.windows?
      system('ATTRIB', '+H', new_backup) if PLATFORM.windows?
    end

    ##
    # 相对日期名。
    #
    # @param target [Date, String, #to_date] 目标日期
    # @param origin [Date, String, #to_date] 原点日期
    # @return [String, nil]
    def self.relative_date_name(target, origin = Date.today)
      target = Date.parse(target) if target.is_a?(String)
      target = target.to_date unless target.is_a?(Date)
      origin = Date.parse(origin) if origin.is_a?(String)
      origin = origin.to_date unless origin.is_a?(Date)

      name5 = %w[前天 昨天 今天 明天 后天].freeze
      name5_offset = 2
      i = target - origin + name5_offset
      return name5[i] if i >= 0 && i < name5.length

      name7 = %w[周一 周二 周三 周四 周五 周六 周日].freeze
      name7_offset = -1
      return name7[target.cwday + name7_offset] if target.cweek == origin.cweek

      return "上#{name7[target.cwday + name7_offset]}" if target.cweek == (origin - 7).cweek

      nil
    end

  end
end
