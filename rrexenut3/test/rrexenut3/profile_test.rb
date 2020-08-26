#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-08-26 – 2020-08-26
# Unlicense

require 'minitest/autorun'

require 'rrexenut3/profile'

class ProfileTest < Minitest::Test
  def test_birthday
    profile = RrExeNut3::Profile.new('test.rrexenut3.profile')
    profile.birthday = Date.today
    _ = profile.birthday
  end

  def test_sex
    profile = RrExeNut3::Profile.new('test.rrexenut3.profile')
    profile.sex = %i[male female].sample
    _ = profile.sex
  end

  def test_weight
    profile = RrExeNut3::Profile.new('test.rrexenut3.profile')
    profile.weight = '50kg'
    _ = profile.weight
  end

  def test_activity
    profile = RrExeNut3::Profile.new('test.rrexenut3.profile')
    profile.insert_activity('TEST.ifri', '100g')
    p profile.select_activities
  end
end
