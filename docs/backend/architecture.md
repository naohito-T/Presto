# Backend Architecture

## Project Introduction
[リファレンス（作成された内容）](https://railsguides.jp/getting_started.html)
[リファレンス（apiモードについて）](https://railsguides.jp/api_app.html)
My PC（Mac M1）だと`lib`ディレクトリができないなど不備がありまくった。
そのためUbuntu上で実行した（今思えばDocker上でやればよかった。）

- project start
dockerから作った。

```sh
# モノレポのため.gitをignoreするオプションをつけた。
$ rails new . -G --api --force -d mysql

# ここでエラーが発生
In Gemfile:
  mysql2
         run  bundle binstubs bundler
Could not find gem 'mysql2 (~> 0.5)' in locally installed gems.
       rails  importmap:install
Could not find gem 'mysql2 (~> 0.5)' in locally installed gems.
Run `bundle install` to install missing gems.
       rails  turbo:install stimulus:install
Could not find gem 'mysql2 (~> 0.5)' in locally installed gems.

# 解決するために以下を参考
# https://zenn.dev/taichiro1102/articles/fb8ce59dd17efc
$ sudo apt-get install libmysqlclient-dev

# 再度install
$ bundle install

# 実行確認
$ bin/rails server
```

## WebSocket
WebSocketを使って何かしたい
NIDに対して何か
