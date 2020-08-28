#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-13 – 2020-08-28
# Unlicense

old, $VERBOSE = $VERBOSE, nil
require 'minitest/autorun'
require 'ruby-units'
$VERBOSE = old

require 'rrexenut3/cn_dris_2013/dris'

class DrisTest < Minitest::Test
  def test_that_new
    RrExeNut3::CnDris2013::Dris.new(sex: :male, age: Unit.new('30y'), weight: Unit.new('100kg'))
  end
end
