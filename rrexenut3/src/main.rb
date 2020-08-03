#!/usr/bin/env ruby -w
# frozen_string_literal: true

# zhengrr
# 2020-07-24 – 2020-08-03
# Unlicense

$LOAD_PATH.unshift(File.expand_path('../lib', __dir__))

require 'colorize'
require 'date'

# 状态
current_date = Date.today
# CLI 选项
prompt_text = 'nil'
prompt_text_color = :light_black
prompt_sigh = 'λ'
prompt_sigh_color = :light_white
command_color = :default
info_color = :green
warning_color = :yellow
danger_color = :red

# 加载用户资料
def load_profile

end

# CLI 循环
if __FILE__ == $PROGRAM_NAME
  loop do
    print prompt_text.colorize(prompt_text_color), ' ', prompt_sigh.colorize(prompt_sigh_color), ' '
    cmdline = gets

    cmdargs = cmdline.gsub(/\s+/m, ' ').strip.split(' ')

    case cmdargs[0]
    when nil
      next

    when 'clear', 'cls'
      # Console Virtual Terminal Sequences
      # ESC 2 J 清屏
      # ESC [ F 将光标移至首行开头
      print "\e[2J\e[F"
      next

    when 'close', 'exit', 'quit'
      break

    else
      print '无法理解 '.colorize(warning_color), cmdargs[0].to_s.colorize(command_color), ' 命令。'.colorize(warning_color), "\n"
      puts '当前可以理解的命令有：'
      puts '  clear|cls       清空屏幕'
      puts '  close|exit|quit 退出程序'
      puts
      next
    end

  end
end
