#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-03 – 2020-08-30
# Unlicense

old, $VERBOSE = $VERBOSE, nil

$VERBOSE = old

require 'rrexenut3/cli/auxiliary'
require 'rrexenut3/profile'

module RrExeNut3
  module Cli
    ##
    # 备份文件。
    #
    #   abc.ext -> abc.ext
    #   .          abc.ext.~20200828T091737000
    #
    # @param path [String, #to_s] 文件路径
    # @param max_count [Fixnum] 最大保留数
    # @param silent [Boolean] 静默，出现异常时返回而不抛出
    def backup_file(path, max_count: 3, silent: true)
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

      command.run('ATTRIB', '+H', new_backup) if platform.windows?
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

    @name = 'nil'
    # 档案名
    # @return [String]
    def self.name
      @name
    end

    @profile = nil
    # 档案对象
    # @return [Profile]
    def self.profile
      raise '尚未加载档案' if @profile.nil?
      @profile
    end

    @focus_date = Data.today
    # 关注日期
    # @return [Date]
    def self.focus_date
      @focus_date
    end

    # 命令行提示符
    #
    #   name RrExeNut3 focus_date Δ
    #
    # @return [String]
    def self.prompt
      date_hint = relative_date_name(@focus_date)
      date_hint &&= "(#{date_hint})"
      date_hint ||= ''

      p1 = pastel.green.(name)
      p2 = pastel.magenta.('RrExeNut3')
      p3 = pastel.yellow.(@focus_date.iso8601 + date_hint)
      p4 = pastel.bright_white.('Δ')

      "#{p1} #{p2} #{p3} #{p4}"
    end

    class Session

      # @return [Boolean]
      def windows?
        !!(RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)
      end

      ##
      # 备份文件。
      #
      #   abc.ext -> abc.ext
      #   .          abc.ext.~20200828T091737000
      #
      # @param path [String, #to_s] 文件路径
      # @param max_count [Fixnum] 最大保留数
      # @param silent [Boolean] 静默，出现异常时返回而不抛出
      def backup_file(path, max_count: 3, silent: true)
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

        system(%(ATTRIB +H "#{new_backup}")) if windows?
      end

      DEFAULT_PROFILE_EXTENSION = '.ren3p'

      ##
      # 加载档案。
      #
      # @param name [String, #to_s] 档案名
      # @param ext [String, #to_s, nil] 后缀名
      # @return [void]
      def load_profile(name, ext = DEFAULT_PROFILE_EXTENSION)
        name = name.to_s unless name.is_a?(String)
        ext = ext.to_s if ext && !ext.is_a?(String)

        path = File.absolute_path("#{name}#{ext}")
        backup_file(path)
        @profile = Profile.new(path, mode: :open)
        @name = name
      end

      ##
      # 加载指定目录下找到的首个档案
      #
      # @param dir [Dir, String, #to_dir]
      def load_first_profile_in_dir(dir = '.', ext = DEFAULT_PROFILE_EXTENSION)
        dir = Dir.new(dir) if dir.is_a?(String)
        dir = dir.to_dir unless dir.is_a?(Dir)
        ext = ext.to_s if ext && !ext.is_a?(String)

        dir.each { |filename| break if filename =~ /(.*)#{ext}$/ }
        load_profile(Regexp.last_match(1)) if Regexp.last_match(1)
      end

      ##
      # 新建档案。
      #
      # @param name [String, #to_s] 档案名
      # @param ext [String, #to_s, nil] 后缀名
      # @return [void]
      def new_profile(name, ext = DEFAULT_PROFILE_EXTENSION)
        name = name.to_s if name.is_a?(String)
        ext = ext.to_s if ext && !ext.is_a?(String)

        @profile = Profile.new(File.absolute_path("#{name}#{ext}"), mode: :new)
        @name = name
      end

      # @param date [Date, String, #to_date]
      # @return [void]
      def birthday=(date)
        profile.birthday = date
      end

      # @return [Unit]
      def age
        Unit.new(@focus_date - profile.birthday, 'days')
      end

      # @param sex [Symbol, #to_sym]
      # @return [void]
      def sex=(sex)
        profile.sex = sex
      end

      # @param weight [Unit, #to_unit]
      # @return [void]
      def weight=(weight)
        profile.weight = weight
      end

      ##
      # 列出当日活动。
      #
      # @return [String]
      def list_activities_in_the_day
        rows = profile.select_activities_by_day(@focus_date)

        rv = ''
        rows.each do |row|
          time, description, ifri, amount = row.values
          name, _nutrients = RrExeNut3::Ifrs.query(ifri)
          rv += "#{time.strftime('%T')}, #{description}, #{name}, #{amount}\n"
        end
        rv
      end

      ##
      # 记录一项活动。
      #
      # @param ifri [String, #to_s]
      # @param amount [Unit, #to_unit] 质量或体积
      # @param description [String, #to_s, nil]
      # @return [void]
      def record_activity(ifri, amount, description)
        raise "没有找到该项 #{ifri}" if RrExeNut3::Ifrs.query(ifri).nil?

        now = Time.now
        time = DateTime.new(@focus_date.year, @focus_date.month, @focus_date.day, now.hour, now.min, now.sec)
        profile.insert_activity(ifri, amount, description, time)
      end

      ##
      # 当日摘要。
      #
      # @return [String]
      def summary_the_day
        rows = profile.select_activities_by_day(@focus_date)
        intake = Nutrients.new
        rows.each do |row|
          _time, _description, ifri, amount = row.values
          _name, nutrients = RrExeNut3::Ifrs.query(ifri)
          intake += nutrients * amount
        end

        dris = RrExeNut3::CnDris2013::Dris.new(sex: profile.sex, age: age, weight: profile.weight)

        RrExeNut3::CnDris2013.summary(intake, dris)
      end
    end
  end
end
