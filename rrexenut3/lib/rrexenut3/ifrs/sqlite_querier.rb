#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-25 – 2020-08-31
# Unlicense

old, $VERBOSE = $VERBOSE, nil
require 'sqlite3'
$VERBOSE = old

require 'rrexenut3/infoods'
require 'rrexenut3/nutrients'

module RrExeNut3
  module Ifrs
    ##
    # SQLite 查询器。
    class SqliteQuerier
      include Singleton

      # @return [String]
      attr_reader :ifri_prefix
      # @return [String]
      attr_reader :table
      # @return [String]
      attr_reader :identifier_column
      # @return [Boolean]
      attr_reader :identifier_with_prefix
      # @return [String]
      attr_reader :name_column
      # @return [String]
      attr_reader :unit_quantity_column

      # @return [SQLite3::Database, nil]
      attr_reader :db
      # @return [Hash{String=>QueryResult}]
      attr_reader :cache

      # @param ifri_prefix [String]
      # @param table [String]
      # @param identifier_column [String]
      # @param identifier_with_prefix [Boolean]
      # @param name_column [String]
      # @param unit_quantity_column [String]
      #--
      # rubocop: disable Metrics/ParameterLists
      #++
      def initialize(ifri_prefix = 'PREFIX.', table: 'ifrs',
                     identifier_column: 'ifri', identifier_with_prefix: true,
                     name_column: 'name', unit_quantity_column: 'unit_quantity')
        @ifri_prefix = ifri_prefix
        @table = table
        @identifier_column = identifier_column
        @identifier_with_prefix = identifier_with_prefix
        @name_column = name_column
        @unit_quantity_column = unit_quantity_column

        @db = SQLite3::Database.new(File.expand_path("#{@ifri_prefix}ifrs", __dir__), { readonly: true })
        @cache = {}
      end

      # rubocop: enable Metrics/ParameterLists

      ##
      # 查询。
      #
      # @param ifri [String, #to_s] 国际食品记录标识符
      # @return [QueryResult, nil] 返回结果或返回空
      def query(ifri)
        ifri = ifri.to_s unless ifri.is_a?(String)

        raise ArgumentError, "查询器 #{self.class.name} 不支持标识符 #{ifri}" unless ifri.start_with?(@ifri_prefix)

        return @cache[ifri] if @cache.include?(ifri)

        query_value = @identifier_with_prefix ? ifri : ifri[@ifri_prefix.length..-1]
        rows = @db.execute2(<<~SQL, [query_value])
          SELECT *
            FROM "#{@table}"
           WHERE "#{@identifier_column}" = ?;
        SQL
        key_row = rows[0]
        value_row = rows[1]

        return if value_row.nil?

        name =
          if key_row.include?(@name_column)
            value_row[key_row.index(@name_column)]
          else
            ifri
          end

        unit_quantity =
          if key_row.include?(@unit_quantity_column)
            value_row[key_row.index(@unit_quantity_column)]
          else
            '100g'
          end

        nut = Nutrients.new(unit_quantity: unit_quantity)
        rows[0].each_index do |i|
          key = key_row[i].to_sym
          value = value_row[i]
          next if value.nil?

          nut[key] = value if Infoods::TAGNAMES.include?(key)
        end

        @cache[ifri] = QueryResult.new(name, nut)
      end
    end
  end
end
