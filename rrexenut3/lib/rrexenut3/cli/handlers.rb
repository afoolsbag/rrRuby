#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-30
# Unlicense

old, $VERBOSE = $VERBOSE, nil
require 'abbrev'
$VERBOSE = old

module RrExeNut3
  module Cli
    # @return [Hash{String=>Symbol}]
    COMMAND_TO_SYMBOL = {}

    # @return [Hash{Symbol=>Array<String>}]
    SYMBOL_TO_PARAMETERS = {}

    # @return [Hash{Symbol=>Array<String>}]
    SYMBOL_TO_OPTIONS = {}

    # @return [Hash{Symbol=>String}]
    SYMBOL_TO_DESCRIPTION = {}

    # @return [Array<String>]
    def self.commands
      COMMAND_TO_SYMBOL.keys
    end

    # @return [Hash{String=>String}]
    def self.command_abbreviations
      commands.abbrev
    end

    ##
    # 建立映射。
    #
    # @param commands [Array<String>] 命令名列表
    # @param symbol [Symbol] 符号
    # @param parameters [Array<String>] 参数列表
    # @param options [Array<String>] 选项列表
    # @param description [String] 描述
    # @return [void]
    def self.map(commands, symbol, parameters, options, description)
      commands.each { |command| COMMAND_TO_SYMBOL[command] = symbol }
      SYMBOL_TO_PARAMETERS[symbol] = parameters
      SYMBOL_TO_OPTIONS[symbol] = options
      SYMBOL_TO_DESCRIPTION[symbol] = description
      nil
    end

    ##
    # 调用命令。
    #
    # @param command [String] 命令名
    # @param arguments [Array<String>] 命令行参数
    # @param session [RrExeNut3::Cli::Session] 命令行界面会话
    # @return [:break, Object] 终止循环标志
    def self.call(command, arguments, session)
      raise NameError, "无法理解 #{command} 命令。" unless COMMAND_TO_SYMBOL.include?(command)

      symbol = COMMAND_TO_SYMBOL[command]
      raise "命令 #{command} 被接受，但其对应方法 #{symbol} 未定义。" unless singleton_methods(false).include?(symbol)

      singleton_method(symbol).call(arguments, session)
    end
  end
end
