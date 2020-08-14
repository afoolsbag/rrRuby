#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-03 – 2020-08-14
# Unlicense

require 'minitest/autorun'

require 'rrexenut3/infoods'

class InfoodsTest < Minitest::Test
  def test_tagname
    tagnames = RrExeNut3::Infoods::TAGNAMES
    tagnames[:WATER]
  end
end
