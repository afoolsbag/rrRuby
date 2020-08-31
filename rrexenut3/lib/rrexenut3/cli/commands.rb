#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-31
# Unlicense

require 'abbrev'

Dir[File.join(__dir__, 'commands', '*.rb')].sort.each(&method(:require))

module RrExeNut3
  module Cli
    ##
    # 命令模块。
    #
    # 整合命令，提供命令相关的元数据支持。
    module Commands
      # @return [Hash{String=>Symbol}]
      COMMAND_TO_SYMBOL.freeze

      # @return [Hash{Symbol=>String}]
      SYMBOL_TO_USAGE.freeze

      # @return [Hash{Symbol=>String}]
      SYMBOL_TO_DESCRIPTION.freeze

      # @return [Array<String>]
      COMMANDS = COMMAND_TO_SYMBOL.keys.freeze

      # @return [Hash{String=>String}]
      ABBREVIATIONS = COMMANDS.abbrev.freeze

      # @param abbreviation [String]
      # @return [String]
      def self.unabridge(abbreviation)
        ABBREVIATIONS[abbreviation] || abbreviation
      end
    end
  end
end
