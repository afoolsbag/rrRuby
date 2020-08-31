#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-31
# Unlicense

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))

require 'rrexenut3/cli'

RrExeNut3::Cli.exec if __FILE__ == $PROGRAM_NAME
