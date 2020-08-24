#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-14 – 2020-08-24
# Unlicense

require 'sqlite3'

require 'rrexenut3/ifrs/identifier'
require 'rrexenut3/infoods'
require 'rrexenut3/nutrients'

module RrExeNut3
  module Ifrs
    # 查询者。
    # Querier.
    class Querier
      include Singleton

      def initialize
        super

        @ifrs_cache = {}
        @local_databases_cache = {}
      end

      ##
      # 绑定本地数据库。
      #
      # @param ifri [Identifier] 国际食品记录标识符
      # @return [void]
      def bind_local_database(ifri, path)
        raise "标识符 #{ifri} 应标识出版物。" unless ifri.as_publication?
        raise "标识符 #{ifri} 已绑定本地数据库，请勿重复绑定。" if @local_databases_cache.include?(ifri)

        @local_databases_cache[ifri] = SQLite3::Database.new(path, { readonly: true })
      end

      ##
      # 查询。
      #
      # @param ifri [Identifier] 国际食品记录标识符
      # @return [Nutrients]
      def query(ifri)
        return @ifrs_cache[ifri] if @ifrs_cache.include?(ifri)

        query_from_local_database(ifri)
      end

      ##
      # 从本地数据库查询。
      #
      # @param ifri [Identifier] 国际食品记录标识符
      # @return [Nutrients, nil]
      def query_from_local_database(ifri)
        return @ifrs_cache[ifri] if @ifrs_cache.include?(ifri)

        db = @local_databases_cache[ifri.publication_code]
        raise "本地数据库 #{ifri.publication_code} 未找到。" if db.nil?

        results = db.execute(<<~SQL, ifri)
          SELECT *
            FROM ifrs
           WHERE ifri = ?;
        SQL

        if (row = results.next)
          nut = Nutrients()
          results.columns.each do |column|
            next unless Infoods::TAGNAMES.include?(column.to_sym)

            Nutrients[column] = row[column]
          end
          nut
        end

        nil
      end

      protected

      # @return [Hash{Identifier=>Nutrients}]
      def ifrs_cache
        @ifrs_cache
      end

      # @return [Hash{Identifier=>SQLite3::Database}]
      def local_databases_cache
        @local_databases_cache
      end

    end
  end
end
