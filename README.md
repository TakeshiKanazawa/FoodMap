# ご近所FoodMap(現在地周辺の飲食店検索アプリ)
※諸々追記予定

### フォルダ構成とクラス

| Folder structure |                                                                                                                                                  | 
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ | 
| Model            | HoPepperSearchAPIModel.swift (検索結果を生成するクラス)                                                                                          | 
|                  | Result.swift                                                                                                                                     | 
| View             | MapViewController.swift                                              (地図、検索画面、検索バー、テーブルビュー表示するクラス)<br> | 
| ViewModel        | HoPepperSearchAPIViewModel.swift(検索バーからの値の受け取り、HotPepperAPI検索／検索結果の返却を行うクラス)                                       | 
| API              | HotPepperAPIClient.swift(HotPepperAPIを呼び出すクラス)                                                                                           | 

### 使用技術
 |                         |                           | 
| ----------------------- | ------------------------- | 
| Architecture            | MVVM                      | 
| Layout                  | 1 StoryBoard + 1 Xib      | 
| Development environment |  xcode 11.0, swift5       | 
| CI/CD                   | Bitrise/fastlane          | 
| libraries               | RxSwift,RxCocoa,AlamoFire | 
| submit                  | 9/7                       | 

### 概要
 - 突発的な飲み会でお店を探せるアプリ。
 - 焼き鳥やイタリアンなど、直感的にmapから探せる
 - 現在地〜目的地までをルート検索する。
 - お気に入り登録機能
 - HotpepperAPIを使用
 - MapKItを使用(GoogleMapAPIを使用したかったがAPI制限ある為断念)
 
 ### Github Flowについて
   - masterブランチは、常にリリース可能な状態。
   - 開発やバグ修正は都度ブランチ切ってわかりやすい名前にする。
   - プルリクエストを使う
   - masterへマージと同時にデプロイする(CI/CDの導入)
   ※GitHubのIssuesとProjectsを活用
 

### その他
UnitTest環境の構築

### 機能
・現在地取得
・周辺の店舗情報取得。店舗カテゴリごとにアノテーションを変更
⇨焼き鳥なら鳥、など
・検索範囲取得(オプショナル)
・お店をタップで店舗情報が見れる
・絞り込み機能
・検索中はloading画面を表示させる

### 完成目標
 - 9/7 AppStore 提出目標
 
## "Done Is Better Than Perfct!"

