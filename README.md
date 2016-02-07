# Autobot

Autobot provides a simple way to generate bot automatically from conversation data,
especially [755](http://7gogo.jp).

```
> オススメの本とかってある？
nanamin：よく聞かれるんだけど、趣味が合うかわかんないからオススメって難しいよ＊＊＊＊＊

今読んでるのはマクベス
```

## Requirements

Autobot requires [MeCab](http://taku910.github.io/mecab) and
[mecab-ipadic-NEologd](https://github.com/neologd/mecab-ipadic-neologd).  
If you use Mac OS X, you can install the former one with [Homebrew](http://brew.sh/index.html):

```
$ brew install mecab
```
## Installation

Put this in your Gemfile:

```ruby
gem "autobot", github: "yasaichi/autobot"
```

And then execute:

```
$ bundle install
```

## Usage

Run setup command:

```
$ bundle exec autobot setup
```

Now you can start conversation with Autobot:

```
$ bundle exec autobot start
```

## Contributing

You should follow the steps below:

1. [Fork the repository](https://help.github.com/articles/fork-a-repo/)
2. Create a feature branch: `git checkout -b add-new-feature`
3. Commit your changes: `git commit -am 'add new feature'`
4. Push the branch: `git push origin add-new-feature`
4. [Send us a pull request](https://help.github.com/articles/using-pull-requests/)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
