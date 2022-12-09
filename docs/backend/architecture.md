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

## Comment

コメントについてはYARDに従っている

## Lint
[リファレンス](https://github.com/rubocop/rubocop/blob/master/config/default.yml)
[参考URL](https://qiita.com/List202/items/38b7fdfb5cc8d85d66e4)

Rubocopを使用。
コードに対して実行される様々なチェックを`cops`と呼ぶ。
`cops`は特定の違反を検出する責任があり、その違反部門ごとに`cops`はグループ化されている。

## Seed

Railsに元々ある仕組み`rake db:seed`は実行するたびに同じデータが登録されてしまう。
そのため`seed-fu`を当プロジェクトでは使用している。
seed-fuは、すでに存在しているが変更したいレコードだけ更新したり、ファイル単位で実行できたり、簡単に書けるようなシンタックスシュガーがあったりと便利

## Logger
[リファレンス](https://railsguides.jp/debugging_rails_applications.html)

Railsに元々ある仕組みを採用。
tagなどを付与できるため検索DXを向上させるためタグを付与する。
