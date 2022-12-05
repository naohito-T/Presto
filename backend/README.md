# README

立ち上げまでの流れ

```sh
$ . ./env.sh
# M1チップ搭載のMac上で環境構築する場合はdocker-compose.ymlに記載されている'platform: linux/amd64'のコメントアウトを外してください
# docker-compose build の alias
$ build
$ bundle install
# local で使う API キーの類を復号する
# LastPass -> Shared-Parrot -> Rails development.secret.encrypted.yml からパスワードをコピーする
# 以下のコマンドを実行するとパスワードを聞かれるので上記の物を入力します。分からない人は他のエンジニアに聞いてください
$ bundle exec thor credentials:decrypt
# DB作成, migration, seedデータ追加
$ rails ridgepole:initialize_db

$ rails db:seed_fu
# rails app だけ立ち上げるとき
$ app
# CSS, JS
$ yarn install
# bin/dev でまとめて起動できるけど docker の外でやった方が速い
$ yarn build --watch
$ yarn build:css --watch
# Sidekiq のコンテナだけ立ち上げるとき
$ worker
# 全部
$ up
```

## DBの構造を変更する場合

```sh
# ridgepoleの実行内容確認
$ rails ridgepole:dry
# 上記を反映
$ rails ridgepole:apply
```

`rails ridgepole:dry`コマンドで差分が表示されない場合は各環境（nightly, staging, production）に直接SQLで反映させてください。

また、`rails ridgepole:dry`コマンドで差分が表示されない変更をDBに加えた場合、そのブランチを取り込んだ他の開発者に影響が出るためローカルのDBの初期化、再構成を行なうようチャットツールなどで周知してください。

## 環境変数を追加する場合

	@@ -60,7 +41,7 @@ $ rails ridgepole:apply

```sh
# パスワードを聞かれるのでこれまで設定してあったものと同じものを入れる
$ bundle exec thor credentials:encrypt
```

## マネジメントページのユーザ追加方法
	@@ -77,7 +58,7 @@ SystemAdmin.create!(id: ULID.generate, email: '{ユーザID}', password: '{パ
### ユーザー退会ジョブをローカルで動かす方法

```
docker-compose exec app \
bundle exec rails aws:sqs:send_user_delete_message \
USER_ID="(退会させるユーザー名)" DELETED_AT="(退会させる日付)"
```