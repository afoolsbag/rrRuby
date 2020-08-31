#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-30
# Unlicense

old, $VERBOSE = $VERBOSE, nil
require 'pastel'
require 'tty-command'
require 'tty-logger'
require 'tty-platform'
$VERBOSE = old

module RrExeNut3
  module Cli
    COMMAND = TTY::Command.new
    # @return [TTY::Command]
    def self.command
      COMMAND
    end

    LOGGER = TTY::Logger.new
    # @return [TTY::Logger]
    def self.logger
      LOGGER
    end

    PASTEL = Pastel.new
    # @return [Pastel::Delegator]
    def self.pastel
      PASTEL
    end

    PLATFORM = TTY::Platform.new
    # @return [TTY::Platform]
    def self.platform
      PLATFORM
    end
  end
end
