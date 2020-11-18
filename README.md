# zhengrr 所知的 Ruby

[Ruby](https://www.ruby-lang.org/) 始于 1995 年，最初由松本行弘创作。

## 参考

*   [Ruby 文档](https://www.ruby-lang.org/zh_cn/documentation/)
*   [Ruby-Doc.org: Documenting the Ruby Language](https://ruby-doc.org/)
    *   [内核参考](https://ruby-doc.org/core/)
    *   [标准库参考](https://ruby-doc.org/stdlib/)
*   [RubyDoc.info: Documenting RubyGems, Stdlib, and GitHub Projects](https://www.rubydoc.info/)
*   [Ruby API](https://rubyapi.org/)
*   [Ruby QuickRef | zenspider.com | by ryan davis](http://zenspider.com/ruby/quickref.html)

## 风格

*   [The Ruby Style Guide](https://rubystyle.guide/) ([cmn-Hans](https://github.com/JuanitoFatas/ruby-style-guide/blob/master/README-zhCN.md))
*   [What is a gem? - RubyGems Guides](https://guides.rubygems.org/what-is-a-gem/)

## 指南

*   [Ruby Tutorial - Learn Ruby](http://rubylearning.com/)
*   [Ruby Documentation Bundle](https://ruby-doc.org/docs/ruby-doc-bundle/)
*   [Ruby Programming - Wikibooks, open books for an open world](https://wikibooks.org/wiki/Ruby_Programming)
*   [Programming Ruby 中文版：第 2 版](# "ISBN 978-7-121-03815-0")
*   松本行弘的程序世界

## Awesome

[Awesome Ruby](https://awesome-ruby.com/)  
[The Ruby Toolbox](https://www.ruby-toolbox.com/)

*   [Bundler](https://bundler.io/)
    *   [Gemfile](https://bundler.io/man/gemfile.5.html)
*   [minitest](https://github.com/seattlerb/minitest)
*   [Rake](https://ruby.github.io/rake/)
    *   [Rakefile](https://ruby.github.io/rake/doc/rakefile_rdoc.html)
*   [rbenv](https://github.com/rbenv/rbenv)
*   [RDoc](https://ruby.github.io/rdoc/)
    *   [writing-doc](https://ruby.github.io/rdoc/README_rdoc.html#label-Writing+Documentation)
    *   [markup-ref](https://ruby.github.io/rdoc/RDoc/Markup.html#class-RDoc::Markup-label-RDoc+Markup+Reference)
*   [RSpec](https://rspec.info/)
    *   [better](http://www.betterspecs.org/) ([cmn-Hans](http://www.betterspecs.org/zh_cn/))
*   [RubyGems](https://rubygems.org/)
*   [Ruby Installer](https://rubyinstaller.org/)
*   [RubyMine](https://jetbrains.com/ruby/) ([zh_CN](https://github.com/pingfangx/jetbrains-in-chinese/tree/master/RubyMine))
*   [Ruby Version Manager](https://rvm.io/)
*   [test-unit](https://test-unit.github.io/)
*   [YARD](https://yardoc.org/)
    *   [Tags](https://rubydoc.info/gems/yard/file/docs/Tags.md)

### Ruby 版本管理器 rbenv

``` batch
:: 列出可用版本
%USERPROFILE%> rbenv install --list

:: 下载某版本
%USERPROFILE%> rbenv install <version>

:: 列出已安装版本
%USERPROFILE%> rbenv versions

:: 选择全局版本
%USERPROFILE%> rbenv global <version>

:: 同步垫片
%USERPROFILE%> rbenv rehash
```

参见：

*   [rbenv: Groom your app’s Ruby environment](https://github.com/rbenv/rbenv)
*   [rbenv for Windows](https://github.com/nak1114/rbenv-win)

### Ruby 运行时

``` batch
:: 使用 Scoop 安装 Ruby 运行时
%USERPROFILE%> scoop install ruby

:: 交互式 Ruby 壳层
%USERPROFILE%> irb

:: 运行脚本
%USERPROFILE%> ruby -w <script.rb>
```

### Ruby 包管理器 RubyGems

环境变量 `GEM_HOME` 指定 Gem 安装位置，环境变量 `GEM_PATH` 指定 Gem 查找位置，`GEM_PATH` 应包含 `GEM_HOME`。

``` batch
:: 列出源
%USERPROFILE%> gem sources [--list]
:: abbr.       gem sources [-l]

:: 增加源
%USERPROFILE%> gem sources --add
:: abbr        gem sources -a

:: 去除源
%USERPROFILE%> gem sources --remove
:: abbr.       gem sources -r

:: 清空源和缓存
%USERPROFILE%> gem sources --clear-all
:: abbr.       gem sources -c

:: 更新缓存
%USERPROFILE%> gem sources --update
:: abbr.       gem sources -u

:: 配置镜像
%USERPROFILE%> gem sources -a https://gems.ruby-china.com/ -r https://rubygems.org/

:: 升级 RubyGems
%USERPROFILE%> gem update --system

:: 列出已安装的 Gem
%USERPROFILE%> gem list --locale
:: abbr.       gem list -l

:: 按名称查询 Gem
%USERPROFILE%> gem query --remote --name <name>
:: abbr.       gem query -rn <name>

:: 安装 Gem
%USERPROFILE%> gem install <gem> --remote
:: abbr.       gem install <gem> -r

:: 升级 Gem
%USERPROFILE%> gem update <gem> --remote
:: abbr.       gem update <gem> -r

:: 卸载 Gem
%USERPROFILE%> gem uninstall <gem>

:: 运行本地 Gem RDoc 文档服务
%USERPROFILE%> gem server
```

参见：

*   [RubyGems: Library packaging and distribution for Ruby.](https://github.com/rubygems/rubygems)
*   [RubyGems.org | Ruby 社区 Gem 托管](https://rubygems.org/)

### Ruby 环境管理器 Bundler

``` batch
:: 依 Gemfile 安装依赖的 Gem
%USERPROFILE%> bundle install
```

参见 [Bundler](https://bundler.io/)。

### Ruby 文档生成器 RDoc

``` batch
:: 依代码注释生成文档
%USERPROFILE%> rdoc
```

参见 [RDoc](https://github.com/ruby/rdoc)。

## 许可

项目采用 Unlicense 许可，文档采用 CC0-1.0 许可：

<p xmlns:dct="https://purl.org/dc/terms/">
  <a rel="license"
     href="https://creativecommons.org/publicdomain/zero/1.0/">
    <img src="https://licensebuttons.net/p/zero/1.0/88x31.png" style="border-style: none;" alt="CC0" />
  </a>
  <br />
  To the extent possible under law,
  <span resource="[_:publisher]" rel="dct:publisher">
    <span property="dct:title">zhengrr</span></span>
  has waived all copyright and related or neighboring rights to this work.
</p>
