#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-14 – 2020-08-28
# Unlicense

old, $VERBOSE = $VERBOSE, nil
require 'ruby-units'
require 'sqlite3'
$VERBOSE = old

module RrExeNut3
  ##
  # 档案。
  class Profile
    MODE_VALID_VALUES = %i[open new open_or_new].freeze

    ##
    # 初始化。
    #
    # @param path [String]
    # @param mode [Symbol]
    def initialize(path, mode: :open_or_new)
      raise ArgumentError, "Unexpected path argument: #{path}" unless path.is_a?(String)
      raise ArgumentError, "Unexpected mode argument: #{mode}" unless MODE_VALID_VALUES.include?(mode)

      if File.exist?(path)
        raise "档案 #{path} 已存在。" unless %i[open open_or_new].include?(mode)

        @db = SQLite3::Database.new(path)
      else
        raise "档案 #{path} 不存在。" unless %i[new open_or_new].include?(mode)

        @db = SQLite3::Database.new(path)
        initialize_database
      end
    end

    ##
    # 获取生日。
    #
    # @return [Date, nil]
    def birthday
      rows = @db.execute(<<~SQL)
        SELECT birthday
          FROM birthday;
      SQL
      raise 'Database corruption: multiple birthday rows.' if rows.length > 1

      birthday, * = rows[0]

      Date.parse(birthday) if birthday
    end

    ##
    # 设定生日。
    #
    # @param date [Date, String, #to_date] 日期
    # @return [void]
    def birthday=(date)
      date = Date.parse(date) if date.is_a?(String)
      date = date.to_date unless date.is_a?(Date)

      rows = @db.execute(<<~SQL)
        SELECT COUNT(*)
          FROM birthday;
      SQL
      cnt, * = rows[0]

      if cnt.zero?
        @db.execute(<<~SQL, [date.iso8601])
          INSERT INTO birthday (birthday)
          VALUES (?);
        SQL
      elsif cnt == 1
        @db.execute(<<~SQL, [date.iso8601])
          UPDATE birthday
             SET birthday = ? 
           WHERE birthday = 
                 (SELECT birthday
                    FROM birthday
                   LIMIT 1);
        SQL
      else
        raise 'Database corruption: multiple birthday rows.'
      end
    end

    SexRow = Struct.new(
      # @return [Date]
      :date,
      # @return [Symbol]
      :sex
    )

    ##
    # 查询最近的性别、孕期或哺乳期。
    #
    # @param date [Date, String, #to_date] 锚定日期
    # @return [SexRow, nil]
    def select_recent_sex(date)
      date = Date.parse(date) if date.is_a?(String)
      date = date.to_date unless date.is_a?(Date)

      rows = @db.execute(<<~SQL, [date.iso8601])
        SELECT date, sex
          FROM sex
         WHERE date <= date(?)
         ORDER BY date DESC
         LIMIT 1;
      SQL
      return if rows[0].nil?

      date, sex, * = rows[0]
      SexRow.new(Date.parse(date), sex.to_sym)
    end

    # @return [Symbol, nil]
    def sex
      select_recent_sex(Date.today)&.sex
    end

    ##
    # 插入性别、孕期或哺乳期。
    #
    # @param sex [Symbol, #to_sym]
    # @param date [Date, String, #to_date]
    # @return [void]
    def insert_sex(sex, date = Date.today)
      sex = sex.to_sym unless sex.is_a?(Symbol)
      date = Date.parse(date) if date.is_a?(String)
      date = date.to_date unless date.is_a?(Date)

      @db.execute(<<~SQL, [date.iso8601, sex.to_s])
        INSERT OR REPLACE INTO sex (date, sex)
        VALUES (?, ?);
      SQL
      nil
    end

    # @param sex [Symbol, #to_sym]
    # @return [void]
    def sex=(sex)
      insert_sex(sex, Date.today)
    end

    WeightRow = Struct.new(
      # @return [Date]
      :date,
      # @return [Unit]
      :weight
    )

    ##
    # 查询最近的体重。
    #
    # @param date [Date, String, #to_date] 锚定日期
    # @return [Unit, nil]
    def select_recent_weight(date)
      date = Date.parse(date) if date.is_a?(String)
      date = date.to_date unless date.is_a?(Date)

      rows = @db.execute(<<~SQL, [date.iso8601])
        SELECT date, weight
          FROM weight
         WHERE date <= date(?)
         ORDER BY date DESC
         LIMIT 1;
      SQL
      return if rows[0].nil?

      date, weight, * = rows[0]
      WeightRow.new(Date.parse(date), Unit.new(weight))
    end

    # @return [Unit, nil]
    def weight
      select_recent_weight(Date.today)&.weight
    end

    ##
    # 插入体重。
    #
    # @param weight [Unit, #to_unit]
    # @param date [Date, String, #to_date]
    # @return [void]
    def insert_weight(weight, date = Date.today)
      weight = weight.to_unit unless weight.is_a?(Unit)
      date = Date.parse(date) if date.is_a?(String)
      date = date.to_date unless date.is_a?(Date)

      @db.execute(<<~SQL, [date.iso8601, weight.to_s])
        INSERT OR REPLACE INTO weight (date, weight)
        VALUES (?, ?);
      SQL
    end

    # @param weight [Unit, #to_unit]
    # @return [void]
    def weight=(weight)
      insert_weight(weight, Date.today)
    end

    ActivityRow = Struct.new(
      # @return [DateTime]
      :time,
      # @return [String, nil]
      :description,
      # @return [String]
      :ifri,
      # @return [Unit]
      :amount
    )

    # @param date [Date, String, #to_date]
    # @return [Array<ActivityRow>]
    def select_activities_by_day(date = Date.today)
      date = Date.parse(date) if date.is_a?(String)
      date = date.to_date unless date.is_a?(Date)

      rows = @db.execute(<<~SQL, [date.iso8601])
        SELECT time, description, ifri, amount
          FROM activities
         WHERE date(?1) <= time
           AND time < date(?1, '+1 day')
      SQL

      rv = []
      rows.each { |row| rv.append(ActivityRow.new(DateTime.parse(row[0]), row[1], row[2], row[3].to_unit)) }
      rv
    end

    # @param ifri [String, #to_s]
    # @param amount [Unit, #to_unit] 质量或体积
    # @param description [String, #to_s, nil]
    # @param time [DateTime, String, #to_datetime]
    # @return [void]
    def insert_activity(ifri, amount, description = nil, time = DateTime.now)
      ifri = ifri.to_s unless ifri.is_a?(String)
      amount = amount.to_unit unless amount.is_a?(Unit)
      description = description.to_s if description && !description.is_a?(String)
      time = DateTime.parse(time) if time.is_a?(String)
      time = time.to_datetime unless time.is_a?(DateTime)

      raise ArgumentError, "Unexpected amount argument: #{amount}" unless %i[mass volume].include?(amount.kind)

      @db.execute(<<~SQL, [time.iso8601, description, ifri, amount.to_s])
        INSERT OR REPLACE INTO activities (time, description, ifri, amount)
        VALUES (?, ?, ?, ?);
      SQL
      nil
    end

    private

    ##
    # 新建数据库时的初始化。
    def initialize_database
      @db.execute <<~SQL
        CREATE TABLE birthday (
          birthday TEXT NOT NULL  -- ISO 8601 日期，如 '2020-08-14'
        );
      SQL

      @db.execute <<~SQL
        CREATE TABLE sex (
          date TEXT PRIMARY KEY NOT NULL,  -- ISO 8601 日期，如 '2020-08-14'
          sex  TEXT             NOT NULL   -- 生理性别、孕期或哺乳期 
        );
      SQL

      @db.execute <<~SQL
        CREATE TABLE weight (
          date   TEXT PRIMARY KEY NOT NULL,  -- ISO 8601 日期，如 '2020-08-14'
          weight TEXT             NOT NULL   -- 带单位的量，如 '65kg' 等
        );
      SQL

      @db.execute <<~SQL
        CREATE TABLE activities (
          time        TEXT NOT NULL,  -- ISO 8601 时间，如 '2020-08-14T08:00:00'
          description TEXT,           -- 描述
          ifri        TEXT NOT NULL,  -- 国际食品记录标识符（International Food Record Identifier）
          amount      TEXT NOT NULL,  -- 带单位的量，如 '350g'、'6km' 等
          PRIMARY KEY(time, ifri)
        );
      SQL
    end
  end
end
