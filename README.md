# GolfCount

GolfCount は、Apple Watch 単体で使うゴルフ用のカウントアプリです。
ラウンド中に `打数` `パット` `ペナルティ` を `+1 / -1` で素早く記録し、18ホール合計のスコアを常に先頭で確認できます。

このアプリは iPhone 同期を行わず、Apple Watch 内にローカル保存する前提で設計しています。

## アプリ概要

- Apple Watch だけで素早くスコアをメモすることを目的にしたアプリ
- 入力項目は `打数` `パット` `ペナルティ` の3つに限定
- 1H〜18H を直接選択して、そのホールの値を修正可能
- 最上部に 18 ホール合計スコアを表示
- データは `UserDefaults` に保存し、アプリ再起動後も保持

## 主な機能

- 18ホール合計スコアの表示
- ホール選択 `1H〜18H`
- `打数 / パット / ペナルティ` の加算・減算
- `パット <= 打数` の制約
- リセット確認ダイアログ
- Apple Watch の触覚フィードバック
- VoiceOver を意識したアクセシビリティラベル

## 対象ユーザーと前提

- iPhone を出さずに Apple Watch だけでスコアを記録したい人
- 操作項目を絞って、素早くメモしたい人
- シンプルなスコア記録を優先し、Watch 内ローカル保存で完結したい人

## 開発環境

現時点の確認環境は次のとおりです。

- Xcode `26.2`
- Swift / SwiftUI
- watchOS Deployment Target `26.2`
- Project Version `1.0`
- Build Number `1`

## セットアップ

### Xcode で起動する

1. `GolfCountApp.xcodeproj` を Xcode で開く
2. Scheme / Target として `GolfCountApp Watch App` を選ぶ
3. Apple Watch Simulator もしくは実機を選ぶ
4. Run する

### コマンドラインでビルドする

```sh
xcodebuild -project 'GolfCountApp.xcodeproj' -target 'GolfCountApp Watch App' -sdk watchos CODE_SIGNING_ALLOWED=NO build
```

## アーキテクチャ

小規模アプリですが、責務が View に寄りすぎないように layered MVVM ベースで構成しています。

- `App`
  - 起動点と依存関係の組み立て
- `Presentation`
  - View、ViewModel、ViewData、UI 補助
- `Domain`
  - スコアルール、値の制約、集計
- `Data`
  - 永続化の実装

依存関係は次の向きに限定しています。

- `App -> Presentation -> Domain`
- `Presentation -> Data(Protocol経由)`
- `Data -> Domain`

## データ保存

- 保存先は Apple Watch 内の `UserDefaults`
- iPhone 同期なし
- クラウド同期なし
- 旧データ形式が存在する場合は、現行の 18 ホール構造へ移行

## ディレクトリ構成

- `GolfCountApp Watch App/App`
  - アプリの起動点、DI コンテナ
- `GolfCountApp Watch App/Presentation`
  - 画面、表示用データ、ViewModel、UI サポート
- `GolfCountApp Watch App/Domain`
  - スコア計算、入力制約、Entity
- `GolfCountApp Watch App/Data`
  - Repository と保存処理
- `DOC`
  - 設計、構成、UI 方針、GitHub 運用ドキュメント
- `.github`
  - PR テンプレート、GitHub Actions

## ドキュメント

詳細は `DOC` 配下にまとめています。

- `DOC/README.md`
- `DOC/ARCHITECTURE.md`
- `DOC/STRUCTURE.md`
- `DOC/UI_GUIDELINES.md`
- `DOC/NEXT_ACTIONS.md`
- `DOC/GITHUB_SETTINGS.md`

## CI

GitHub Actions で `watchos-build` を実行し、watchOS ターゲットのビルド確認を行います。

## 今後の拡張候補

- Digital Crown を使った入力
- ラウンド履歴の保存
- パーやメモ欄の追加
- スコア分析や統計表示
