#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-09-03 – 2020-09-03
# Unlicense

require 'rrexenut3/ifrs/handlers'
require 'rrexenut3/ifrs/sqlite_querier'

module RrExeNut3
  module Ifrs
    ##
    # 查询器。
    class XX_Boohee_Querier < SqliteQuerier
      def initialize
        super('XX.Boohee.', identifier_column: 'code', identifier_with_prefix: false)
      end
    end

    HANDLERS.merge!(
      'XX.Boohee.': XX_Boohee_Querier
    )
  end
end
