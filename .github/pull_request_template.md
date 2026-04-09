## 概要

-

## 背景

-

## 変更内容

-

## 確認内容

- [ ] `xcodebuild -project 'GolfCountApp.xcodeproj' -target 'GolfCountApp Watch App' -sdk watchos CODE_SIGNING_ALLOWED=NO build`
- [ ] Apple Watch 実機で基本操作を確認

## リスク / フォローアップ

-

## レビュー運用メモ

- `gh pr comment` で `riku-tamura` アカウントから `@codex日本語でレビューしてください` を投稿する
- 依頼後は、`chatgpt-codex-connector` の返信コメントまたはレビューが返るまで待機する
- 指摘がある場合は、レビューコメントとして残す
- 修正が必要な場合は、先にコードや設定やドキュメントを修正する
- 修正後に、修正内容をコメントで明記する
- 修正しない場合は、修正しない理由をコメントで明記する
- 指摘対応後は再レビューを行う
- 問題がなければ `LGTM` コメントを行ってから merge する
- 別レビュワーがいる場合は approve も行う
