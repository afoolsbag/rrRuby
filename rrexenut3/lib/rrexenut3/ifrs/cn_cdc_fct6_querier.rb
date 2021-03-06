#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-14 – 2020-08-28
# Unlicense

require 'rrexenut3/ifrs/handlers'
require 'rrexenut3/ifrs/sqlite_querier'

module RrExeNut3
  module Ifrs
    ##
    # 查询器。
    class CN_CDC_FCT6_Querier < SqliteQuerier
      def initialize
        super('CN.CDC.FCT6.', identifier_column: 'code', identifier_with_prefix: false)
      end
    end

    HANDLERS.merge!(
      'CN.CDC.FCT6.': CN_CDC_FCT6_Querier
    )
  end
end
