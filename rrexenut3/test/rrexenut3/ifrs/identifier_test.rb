#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-24 – 2020-08-24
# Unlicense

require 'minitest/autorun'

require 'rrexenut3/ifrs/identifier'

class IdentifierTest < Minitest::Test
  def test_that_as_country
    ifri = RrExeNut3::Ifrs::Identifier.new('XX')
    assert ifri.as_country?
  end
end
