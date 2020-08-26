#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-14 – 2020-08-26
# Unlicense

require 'rrexenut3/ifrs/sqlite_querier'

module RrExeNut3
  module Ifrs
    ##
    # 查询器。
    class CnCdcFct6Querier < SqliteQuerier
      def initialize
        super('CN.CDC.FCT6.', identifier_column: 'code', identifier_with_prefix: false)
      end
    end
  end
end
