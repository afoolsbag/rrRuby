#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-25 – 2020-08-26
# Unlicense

require 'minitest/autorun'

require 'rrexenut3/ifrs'

class IfrsTest < Minitest::Test
  def test_ifrs
    # nut = RrExeNut3::Ifrs.query('CN.NHC.LPF.6914782203327')
    # p nut
    RrExeNut3::Ifrs.query('CN.NHC.LPF.6914782203327')
  end
end
