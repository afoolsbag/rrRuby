#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-31
# Unlicense


require 'rrexenut3/cli/session'

module RrExeNut3
  module Cli
    module Commands
      # @return [Hash{String=>Symbol}]
      COMMAND_TO_SYMBOL = {}

      # @return [Hash{Symbol=>String}]
      SYMBOL_TO_USAGE = {}

      # @return [Hash{Symbol=>String}]
      SYMBOL_TO_DESCRIPTION = {}

      ##
      # 建立映射。
      #
      # @param commands [Array<String>] 命令名列表
      # @param symbol [Symbol] 符号
      # @param usage [String, nil] 使用方法
      # @param description [String] 描述
      # @return [void]
      def self.map(commands, symbol, usage, description)
        commands.each { |command| COMMAND_TO_SYMBOL[command] = symbol }
        SYMBOL_TO_USAGE[symbol] = usage || ''
        SYMBOL_TO_DESCRIPTION[symbol] = description
        nil
      end

      ##
      # 调用命令。
      #
      # @param command [String] 命令名
      # @param arguments [Array<String>] 命令行参数
      # @param session [Session] 命令行会话
      # @return [:break, Object] 终止循环标志
      def self.call(command, arguments, session)
        raise NameError, "无法理解 #{command} 命令。" unless COMMAND_TO_SYMBOL.include?(command)

        symbol = COMMAND_TO_SYMBOL[command]
        raise "命令 #{command} 被接受，但其对应方法 #{symbol} 未定义。" unless singleton_methods(false).include?(symbol)

        singleton_method(symbol).call(arguments, session)
      end
    end
  end
end
