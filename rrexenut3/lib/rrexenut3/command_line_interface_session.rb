#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-03 – 2020-08-04
# Unlicense

require 'colorized_string'
require 'sqlite3'

module RrExeNut3
  ##
  # 命令行接口会话。
  #--
  # rubocop:disable Metrics/ClassLength
  #++
  class CommandLineInterfaceSession
    def initialize
      @muted_text_color = :light_black
      @information_text_color = :light_cyan
      @warning_text_color = :light_yellow
      @success_text_color = :light_green
      @failure_text_color = :light_red

      @profile_name = 'nil'
      @profile_database = nil
      @focus_date = Date.today
    end

    ##
    # 相对日期名。
    #
    # @param target [Date] 目标日期
    # @param origin [Date] 原点日期
    # @return [String. nil]
    #--
    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
    #++
    def self.relative_date_name(target, origin = Date.today)
      case target
      when origin - 2
        return '前天'
      when origin - 1
        return '昨天'
      when origin
        return '今天'
      when origin + 1
        return '明天'
      when origin + 2
        return '后天'
      end

      if target.cweek == origin.cweek
        case target.cwday
        when 1
          return '周一'
        when 2
          return '周二'
        when 3
          return '周三'
        when 4
          return '周四'
        when 5
          return '周五'
        when 6
          return '周六'
        when 7
          return '周日'
        end
      end

      if target.cweek == (origin - 7).cweek
        case target.cweek
        when 1
          return '上周一'
        when 2
          return '上周二'
        when 3
          return '上周三'
        when 4
          return '上周四'
        when 5
          return '上周五'
        when 6
          return '上周六'
        when 7
          return '上周日'
        end
      end

      nil
    end

    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity

    ##
    # 提示文本。
    #
    #   profile_name RrExeNut3 focus_date
    #
    # @return [ColorizedString]
    #--
    # rubocop:disable Metrics/AbcSize
    #++
    def prompt_text
      focus_date_suffix = RrExeNut3::CommandLineInterfaceSession.relative_date_name(@focus_date)
      focus_date_suffix = '(' + focus_date_suffix + ')' if focus_date_suffix
      ColorizedString.new(
        ColorizedString[@profile_name].colorize(:green) + ' ' + \
        ColorizedString['RrExeNut3'].colorize(:magenta) + ' ' + \
        ColorizedString[@focus_date.iso8601 + focus_date_suffix].colorize(:yellow)
      )
    end
    # rubocop:enable Metrics/AbcSize

    ##
    # 提示符号。
    #
    # @return [ColorizedString]
    def prompt_sign
      ColorizedString['¿'].colorize(:light_white)
    end

    ##
    # 静音文本。
    #
    # @param text [String] 原始文本
    # @return [ColorizedString] 富文本
    def mute(text)
      ColorizedString[text].colorize(@muted_text_color)
    end

    ##
    # 消息文本。
    #
    # @param text [String] 原始文本
    # @return [ColorizedString] 富文本
    def info(text)
      ColorizedString[text].colorize(@information_text_color)
    end

    ##
    # 警告文本。
    #
    # @param text [String] 原始文本
    # @return [ColorizedString] 富文本
    def warn(text)
      ColorizedString[text].colorize(@warning_text_color)
    end

    ##
    # 成功文本。
    #
    # 用于报告命令成功。
    #
    # @param text [String] 原始文本
    # @return [ColorizedString] 富文本
    def succ(text)
      ColorizedString[text].colorize(@success_text_color)
    end

    ##
    # 失败文本。
    #
    # 用于报告命令失败。
    #
    # @param text [String] 原始文本
    # @return [ColorizedString] 富文本
    def fai1(text)
      ColorizedString[text].colorize(@failure_text_color)
    end

    ##
    # 变更焦点日期。
    #
    # @param new_date [Date] 新日期
    # @return [void]
    def change_focus_date(new_date)
      @focus_date = new_date
    end

    ##
    # 加载档案。
    #
    # @param name [String] 档案名
    # @return [void]
    def load_profile(name)
      path = File.absolute_path(name + '.rrexenut3.profile')
      raise "档案 #{name} 不存在。" unless File.exist?(path)

      @profile_database = SQLite3::Database.new(path)
      @profile_name = name

      change_focus_date(@focus_date)
    end

    ##
    # 新建档案。
    #
    # @param name [String] 档案名
    # @return [void]
    def new_profile(name)
      path = File.absolute_path(name + '.rrexenut3.profile')
      raise "档案 #{name} 已存在。" if File.exist?(path)

      db = SQLite3::Database.new(path)
      db.close
    end
  end

  # rubocop:enable Metrics/ClassLength
end
