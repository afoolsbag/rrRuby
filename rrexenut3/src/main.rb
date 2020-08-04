#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-03
# Unlicense

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))

require 'colorized_string'
require 'date'

require 'rrexenut3/command_line_interface_session'

##
# 帮助。
#
# @param args [Array<String>] 命令行参数
# @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
# @return [void]
#--
# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
#++
def show_help(args, sess)
  _ = args
  puts '当前可以理解的命令有：'
  puts '  <                            ' + sess.mute('切换到前一天')
  puts '  >                            ' + sess.mute('切换到后一天')
  puts '  ?                            ' + sess.mute('帮助')
  puts '  clear                        ' + sess.mute('清空屏幕')
  puts '  close                        ' + sess.mute('退出程序')
  puts '  cls                          ' + sess.mute('清空屏幕')
  puts '  change <date>                ' + sess.mute('切换到某一天')
  puts '  do <exercise> <amount>       ' + sess.mute('运动，录入当日活动')
  puts '  drink <drink> <intake>       ' + sess.mute('饮水，录入当日活动')
  puts '  eat <food> <intake>          ' + sess.mute('进食，录入当日活动')
  puts '  exercise <exercise> <amount> ' + sess.mute('运动，录入当日活动')
  puts '  exit                         ' + sess.mute('退出程序')
  puts '  help                         ' + sess.mute('帮助')
  puts '  ingest <substance> <intake>  ' + sess.mute('摄入，录入当日活动')
  puts '  l                            ' + sess.mute('列出当日活动')
  puts '  list                         ' + sess.mute('列出当日活动')
  puts '  ll                           ' + sess.mute('列出当日活动')
  puts '  ls                           ' + sess.mute('列出当日活动')
  puts '  load <profile>               ' + sess.mute('加载档案')
  puts '  new <profile>                ' + sess.mute('新建档案')
  puts '  next                         ' + sess.mute('切换到后一天')
  puts '  prev                         ' + sess.mute('切换到前一天')
  puts '  previous                     ' + sess.mute('切换到前一天')
  puts '  quit                         ' + sess.mute('退出程序')
  puts '  remove <activity>            ' + sess.mute('从当日移除一项活动')
  puts '  rm <activity>                ' + sess.mute('从当日移除一项活动')
  puts '  sum                          ' + sess.mute('显示当日摘要')
  puts '  summary                      ' + sess.mute('显示当日摘要')
  puts '  today                        ' + sess.mute('切换到今天')
  puts
end

# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

##
# 清屏。
#
# @param args [Array<String>] 命令行参数
# @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
# @return [void]
def clear_screen(args, sess)
  _ = args, sess
  # Console Virtual Terminal Sequences
  # ESC 2 J 清屏
  # ESC [ F 将光标移至首行开头
  print "\e[2J\e[F"
end

##
# 加载档案。
#
# @param args [Array<String>] 命令行参数
# @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
# @return [void]
def load_profile(args, sess)
  raise ArgumentError, '该命令需要至少 1 个参数。' if args.length < 2

  profile_name = args[1]

  sess.load_profile(profile_name)
  puts sess.succ("档案 #{profile_name} 加载完毕。")
  puts
end

##
# 新建档案。
#
# @param args [Array<String>] 命令行参数
# @param sess [RrExeNut3::CommandLineInterfaceSession] 命令行界面会话
# @return [void]
def new_profile(args, sess)
  raise ArgumentError, '该命令需要至少 1 个参数。' if args.length < 2

  profile_name = args[1]

  sess.new_profile(profile_name)
  puts sess.succ("档案 #{profile_name} 新建完毕。")
  puts
end

if __FILE__ == $PROGRAM_NAME
  cli_sess = RrExeNut3::CommandLineInterfaceSession.new

  # 自动加载工作目录下，找到的首个档案
  Dir.new('.').each do |filename|
    if filename =~ /(.*)\.rrexenut3\.profile$/
      cli_sess.load_profile(Regexp.last_match(1))
      break
    end
  end

  # rubocop:disable Metrics/BlockLength
  loop do
    print cli_sess.prompt_text, ' ', cli_sess.prompt_sign, ' '
    cmd_line = gets
    cmd_args = cmd_line.gsub(/\s+/m, ' ').strip.split(' ')

    begin
      case cmd_args[0]
      when nil
        nil
      when '<', 'prev', 'previous'
        change_to_previous_day(cmd_args, cli_sess)
      when '>', 'next'
        change_to_next_day(cmd_args, cli_sess)
      when '?', 'help'
        show_help(cmd_args, cli_sess)
      when 'clear', 'cls'
        clear_screen(cmd_args, cli_sess)
      when 'close', 'exit', 'quit'
        break
      when 'do', 'exercise'
        record_exercise(cmd_args, cli_sess)
      when 'drink', 'eat', 'ingest'
        record_ingestion(cmd_args, cli_sess)
      when 'l', 'list', 'll', 'ls'
        show_activities(cmd_args, cli_sess)
      when 'load'
        load_profile(cmd_args, cli_sess)
      when 'new'
        new_profile(cmd_args, cli_sess)
      when 'remove', 'rm'
        remove_activity(cmd_args, cli_sess)
      when 'sum', 'summary'
        show_summary(cmd_args, cli_sess)
      when 'today'
        change_to_today(cmd_args, cli_sess)
      else
        puts cli_sess.fai1('无法理解 ' + cmd_args[0] + ' 命令。')
        puts '键入 help 命令获取帮助。'
        puts
      end
    rescue StandardError => e
      puts cli_sess.fai1(e.message)
      puts
    end
  end
  # rubocop:enable Metrics/BlockLength
end
