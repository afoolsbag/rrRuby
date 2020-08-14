#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-13 – 2020-08-14
# Unlicense

require 'minitest/autorun'

require 'rrexenut3/cn_dris_2013'
require 'rrexenut3/nutrients'

class CnDris2013Test < Minitest::Test
  def test_summary
    nuts = ::RrExeNut3::Nutrients.new
    nuts[:'PRO-'] = Unit.new('100g')

    dris = RrExeNut3::CnDris2013::Dris.new(sex: :male, age: Unit.new('30y'), weight: Unit.new('100kg'))

    RrExeNut3::CnDris2013.summary(nuts, dris)
  end
end
