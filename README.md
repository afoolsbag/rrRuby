# zhengrr 所知的 Ruby

官网 <https://www.ruby-lang.org/>，Ruby 始于 1995 年，最初由松本行弘创作。

## 参考

*   [*Ruby-Doc.org*](https://ruby-doc.org/)
    *   [Ruby 内核参考](https://ruby-doc.org/core/)
    *   [Ruby 标准库参考](https://ruby-doc.org/stdlib/)
*   [*Ruby API*](https://rubyapi.org/)
*   [*zenspider.com 上的 Ruby Quickref*](http://zenspider.com/ruby/quickref.html)

## 风格

*   [*The Ruby Style Guide*](https://rubystyle.guide/) <sub>
        [*cmn-Hans*](https://github.com/JuanitoFatas/ruby-style-guide/blob/master/README-zhCN.md) </sub>
*   RubyGems Guides 上的 [*What is a gem?*](https://guides.rubygems.org/what-is-a-gem/)

## 指南

*   [*Learn Ruby*](http://rubylearning.com/)
*   Ruby-Doc.org 上的 [*Ruby Documentation Bundle*](https://ruby-doc.org/docs/ruby-doc-bundle/)
*   Wikibooks 上的 [*Ruby Programming*](https://wikibooks.org/wiki/Ruby_Programming)
*   [*Programming Ruby 中文版：第 2 版*](http://zbgb.org/278/ZdocDetail3691109.htm "ISBN 978-7-121-03815-0")
*   *松本行弘的程序世界*

## Awesome

[*Awesome Ruby*](https://awesome-ruby.com/)，
[*The Ruby Toolbox*](https://www.ruby-toolbox.com/)。

| [*Rake*](https://ruby.github.io/rake/) <sub>
      [*Rakefile*](https://ruby.github.io/rake/doc/rakefile_rdoc.html) </sub>
| [*RDoc*](https://ruby.github.io/rdoc/) <sub>
      [*writing-doc*](https://ruby.github.io/rdoc/README_rdoc.html#label-Writing+Documentation),
      [*markup-ref*](https://ruby.github.io/rdoc/RDoc/Markup.html#class-RDoc::Markup-label-RDoc+Markup+Reference) </sub>
| [*YARD*](https://yardoc.org/) <sub>
      [*Tags*](https://rubydoc.info/gems/yard/file/docs/Tags.md) </sub>

环境管理
| [*rbenv*](https://github.com/rbenv/rbenv),
  [*Ruby Installer*](https://rubyinstaller.org/),
  [*Ruby Version Manager*](https://rvm.io/)

包管理器
| [*RubyGems*](https://rubygems.org/)
| [*Bundler*](https://bundler.io/) <sub>
      [*Gemfile*](https://bundler.io/man/gemfile.5.html) </sub>

测试
| [*minitest*](https://github.com/seattlerb/minitest)
| [*RSpec*](https://rspec.info/) <sub>
      [*better*](http://www.betterspecs.org/),
      [*-cmn-Hans*](http://www.betterspecs.org/zh_cn/) </sub>
| [*test-unit*](https://test-unit.github.io/)

集成开发
| [*RubyMine*](https://jetbrains.com/ruby/) <sub>
      [*zh_CN*](https://github.com/pingfangx/jetbrains-in-chinese/tree/master/RubyMine) </sub>

### Ruby 运行时

```cmder
:: 使用 Scoop 安装 Ruby 运行时
%USERPROFILE% λ scoop install ruby

:: 交互式 Ruby 壳层
%USERPROFILE% λ irb

:: 运行脚本
%USERPROFILE% λ ruby -w <script.rb>
```

### Ruby 包管理器 RubyGems

[*RubyGems 官网*](https://rubygems.org/)。

环境变量 `GEM_HOME` 指定 Gem 安装位置，环境变量 `GEM_PATH` 指定 Gem 查找位置，`GEM_PATH` 应包含 `GEM_HOME`。

```cmder
:: 列出源
%USERPROFILE% λ gem sources [--list]
:: abbr.        gem sources [-l]

:: 增加源
%USERPROFILE% λ gem sources --add
:: abbr         gem sources -a

:: 去除源
%USERPROFILE% λ gem sources --remove
:: abbr.        gem sources -r

:: 清空源和缓存
%USERPROFILE% λ gem sources --clear-all
:: abbr.        gem sources -c

:: 更新缓存
%USERPROFILE% λ gem sources --update
:: abbr.        gem sources -u

:: 配置镜像
%USERPROFILE% λ gem sources -a https://gems.ruby-china.com/ -r https://rubygems.org/

:: 升级 RubyGems
%USERPROFILE% λ gem update --system

:: 列出已安装的 Gem
%USERPROFILE% λ gem list --locale
:: abbr.        gem liar -l

:: 按名称查询 Gem
%USERPROFILE% λ gem query --remote --name <name>
:: abbr.        gem query -rn <name>

:: 安装 Gem
%USERPROFILE% λ gem install <gem> --remote
:: abbr.        gem install <gem> -r

:: 升级 Gem
%USERPROFILE% λ gem update <gem> --remote
:: abbr.        gem update <gem> -r

:: 卸载 Gem
%USERPROFILE% λ gem uninstall <gem>

:: 运行本地 Gem RDoc 文档服务
%USERPROFILE% λ gem server
```

### Ruby 环境管理器 Bundler

[*Bundler 官网*](https://bundler.io/)。

```cmder
:: 依 Gemfile 安装依赖的 Gem
%USERPROFILE% λ bundle install
```

### Ruby 文档生成器 RDoc

[*RDoc 官网*](https://github.com/ruby/rdoc)。

```cmder
:: 依代码注释生成文档
%USERPROFILE% λ rdoc
```

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
