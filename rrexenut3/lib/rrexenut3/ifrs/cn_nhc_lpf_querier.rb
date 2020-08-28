#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-25 – 2020-08-26
# Unlicense

require 'rrexenut3/ifrs/handlers'
require 'rrexenut3/ifrs/sqlite_querier'

module RrExeNut3
  module Ifrs
    ##
    # 查询器。
    class CN_NHC_LPF_Querier < SqliteQuerier
      def initialize
        super('CN.NHC.LPF.', identifier_column: 'gtin', identifier_with_prefix: false)
      end
    end

    HANDLERS.merge!(
      'CN.NHC.LPF.': CN_NHC_LPF_Querier
    )
  end
end
