#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-13 – 2020-08-14
# Unlicense

require 'minitest/autorun'
require 'ruby-units'

require 'rrexenut3/cn_dris_2013/dri'

class DriTest < Minitest::Test
  def test_empty
    dri = RrExeNut3::CnDris2013::Dri.new
    assert_empty dri
  end

  def test_not_empty
    dri = RrExeNut3::CnDris2013::Dri.new(spl: Unit.new('1'))
    refute_empty dri
  end

  def test_label
    dri = RrExeNut3::CnDris2013::Dri.new
    assert_nil dri.label(:spl)
    refute_empty dri.label(:spl, force: true)
  end
end
