# Cafe_log(カフェログ)

## サイト概要
### サイトテーマ
行きたいカフェを探したり、自分の行ったカフェの記録を投稿、
カフェのレビューサイト

### テーマを選んだ理由
インスタグラムなどで、おしゃれなカフェを投稿しているユーザーを多く見かけ、
自分自身も他のユーザーが載せているカフェの投稿を参考に、
実際に足を運ぶことが多くあったのですが、ハッシュタグでの検索のみのため、
自分の求めている情報をうまく検索できなかったり、
レビューもないので実際足を運ぶと思っていた商品と違うことも多くありました。
自分に限らず、多くの人がインスタグラム等にカフェの投稿をし自身のカフェ活を共有したり、それを参考にし足を運んだ等のコメントも多く見かけます。
コーヒーを好きな人はもちろんのこと、昨今普及しているリモートワーカーがカフェを利用する場面も増えてきていると感じます。
そこで、食べログとインスタを掛け合わせたようなサービスがあると、
カフェを見つけることも、自身のカフェ活を共有することもでき、
多くの人に使ってもらえると考えました。また、カフェを営んでいる経営者側にも
生の声やレビューを通して、客観的な顧客からの評価を見ることができ、より良いカフェになるきっかけにもなると考えています。
上記の理由からカフェのレビューサイト×SNSをテーマにしました。

### ターゲットユーザ
- カフェによく行く人
- コーヒー等が好きな人

### 主な利用シーン
- 気になるカフェを探すとき
- 行ってみたいカフェを見つけるとき
- 自身が言ったカフェの記録を投稿するとき
- お店の評価をするとき

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9

## 機能一覧
- 投稿機能:サイトに登録されているカフェはもちろん、登録されていないカフェも紐づけて投稿することができる
           また、投稿に対していいねやコメントをすることもできる。
- レビュー機能:サイトに登録されているカフェはもちろん、登録されていないカフェに対してもレビューすることができる
- カフェ登録機能:管理者側でカフェの登録をすることができる。また、会員側で登録されていないカフェは編集することができる。
- 検索機能
- マップ表示
- フォロー機能

## その他使用技術
- 非同期通信(フォロー・いいね・コメント機能)
- 外部API(Google Map API、Geocoding API)