#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-14 – 2020-08-14
# Unlicense

require 'sqlite3'

module RrExeNut3
  ##
  # 档案。
  class Profile
    MODE_VALID_VALUES = %i[open new open_or_new].freeze

    ##
    # 初始化。
    #
    # TODO:
    def initialize(path, mode: :open_or_new)
      raise NotImplementedError

      # return [SQLite::Database]
      @db = SQLite3::Database.new(path)
    end

    ##
    # 获取生日。
    #
    # @return [Date]
    def birthday
      raise NotImplementedError
    end

    ##
    # 设定生日。
    #
    # @param date [Date] 日期
    def birthday=(date)
      raise NotImplementedError
    end

    private

    ##
    # 新建数据库时的初始化。
    def initialize_database
      @db.execute <<~SQL
        CREATE TABLE birthday (
          birthday TEXT NOT NULL                 -- ISO 8601 日期，如 '2020-08-14'
        );
      SQL

      @db.execute <<~SQL
        CREATE TABLE sex (
          date     TEXT PRIMARY KEY NOT NULL,    -- ISO 8601 日期，如 '2020-08-14'
          sex      TEXT             NOT NULL     -- 生理性别、孕期或哺乳期 
        );
      SQL

      @db.execute <<~SQL
        CREATE TABLE weight (
          date     TEXT PRIMARY KEY NOT NULL,  -- ISO 8601 日期，如 '2020-08-14'
          weight   TEXT             NOT NULL   -- 带单位的量，如 '65kg' 等
        );
      SQL

      @db.execute <<~SQL
        CREATE TABLE activities (
          time     TEXT NOT NULL,              -- ISO 8601 时间，如 '2020-08-14T08:00:00'
          brief    TEXT,                       -- 简述
          IFRI     TEXT NOT NULL,              -- 国际食品记录标识符（International Food Record Identifier）
          amount   TEXT NOT NULL,              -- 带单位的量，如 '350g'、'6km' 等
          PRIMARY KEY(time, IFRI)
        );
      SQL
    end
  end
end
