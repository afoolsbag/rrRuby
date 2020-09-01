#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-03 – 2020-08-31
# Unlicense

require 'rrexenut3/cli/auxiliary'
require 'rrexenut3/cn_dris_2013'
require 'rrexenut3/ifrs'
require 'rrexenut3/profile'

module RrExeNut3
  module Cli
    ##
    # 会话。
    # Session.
    class Session
      ##
      # 获取档案名。
      #
      # @return [String]
      attr_reader :name

      ##
      # 设置档案名。
      #
      # @param new_name [String, #to_s]
      def name=(new_name)
        new_name = new_name.to_s unless new_name.is_a?(String)

        @name = new_name
      end

      ##
      # 获取档案对象。
      #
      # @return [Profile]
      def profile
        raise '尚未加载档案' if @profile.nil?

        @profile
      end

      ##
      # 设置档案对象。
      #
      # @param new_profile [Profile, #to_profile]
      def profile=(new_profile)
        new_profile = new_profile.to_profile unless new_profile.is_a?(Profile)

        @profile = new_profile
      end

      ##
      # 检查档案对象。
      #
      # @return [Boolean]
      def profile?
        !!@profile
      end

      ##
      # 获取焦点日期。
      #
      # @return [Date]
      attr_reader :focus_date

      ##
      # 设置焦点日期。
      #
      # @param new_date [Date, String, #to_date]
      # @return [Date]
      def focus_date=(new_date)
        new_date = Date.parse(new_date) if new_date.is_a?(String)
        new_date = new_date.to_date unless new_date.is_a?(Date)

        @focus_date = new_date
      end

      ##
      # 初始化方法。
      def initialize
        @name = 'nil'
        @profile = nil
        @focus_date = Date.today
      end

      ##
      # 命令行提示符。
      #
      #   name RrExeNut3 focus_date Δ
      #
      # @return [String]
      def prompt
        date_hint = Cli.relative_date_name(focus_date)
        date_hint &&= "(#{date_hint})"
        date_hint ||= ''

        p1 = PASTEL.green(name)
        p2 = PASTEL.magenta('RrExeNut3')
        p3 = PASTEL.yellow(@focus_date.iso8601 + date_hint)
        p4 = PASTEL.bright_white('Δ')

        "#{p1} #{p2} #{p3} #{p4}"
      end

      DEFAULT_PROFILE_EXTENSION = '.ren3p'

      ##
      # 加载档案。
      #
      # @param path [String, #to_s] 路径
      # @param ext [String, #to_s, nil] 后缀名
      # @param mode [:open, :new, :open_or_new] 模式
      # @return [void]
      def load_profile(path, ext: DEFAULT_PROFILE_EXTENSION, mode: :open)
        path = path.to_s unless path.is_a?(String)
        ext = ext.to_s if ext && !ext.is_a?(String)

        name = File.basename(path, ext)
        file_name = path.end_with?(ext) ? path : "#{path}#{ext}"
        file_path = File.absolute_path(file_name)

        Cli.backup_file(file_path)
        self.profile = Profile.new(file_path, mode: mode)
        self.name = name

        CONFIG.set(:load_path, value: file_path)
        CONFIG.write(force: true)
      end

      ##
      # 加载配置文件指定的档案。
      def load_profile_via_configuration
        return unless CONFIG.exist?

        CONFIG.read
        file_path = CONFIG.fetch(:load_path)
        return unless File.exist?(file_path)

        load_profile(file_path)
      end

      ##
      # 加载指定目录下找到的首个档案。
      #
      # @param dir [Dir, String, #to_dir]
      # @return [void]
      def load_first_profile_in_directory(dir = '.', ext = DEFAULT_PROFILE_EXTENSION)
        dir = Dir.new(dir) if dir.is_a?(String)
        dir = dir.to_dir unless dir.is_a?(Dir)
        ext = ext.to_s if ext && !ext.is_a?(String)

        dir.each do |filename|
          if filename =~ /.*#{ext}$/
            load_profile(filename)
            break
          end
        end
      end

      # @return [Unit]
      def age
        Unit.new(focus_date - profile.birthday, 'days')
      end

      ##
      # 记录一项活动。
      #
      # @param key [String, #to_s]
      # @param amount [Unit, #to_unit] 质量或体积
      # @param description [String, #to_s, nil]
      # @return [void]
      def record_activity(key, amount, description)
        ifri, _name, _nutrients = RrExeNut3::Ifrs.query(key)&.values
        raise "没有找到该项 #{key}" unless ifri

        now = Time.now
        time = DateTime.new(focus_date.year, focus_date.month, focus_date.day, now.hour, now.min, now.sec)
        profile.insert_activity(ifri, amount, description, time)
      end

      ##
      # 当日摘要。
      #
      # @return [String]
      def summary_the_day
        rows = profile.select_activities_by_day(focus_date)
        intake = Nutrients.new
        rows.each do |row|
          _time, _description, ifri, amount = row.values
          _ifri, _name, nutrients = RrExeNut3::Ifrs.query(ifri)&.values
          intake += nutrients * amount
        end

        dris = RrExeNut3::CnDris2013::Dris.new(sex: profile.sex, age: age, weight: profile.weight)

        RrExeNut3::CnDris2013.summary(intake, dris)
      end
    end
  end
end
