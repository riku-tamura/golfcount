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

- `chatgpt-codex-connector` へのレビュー依頼は GitHub Actions から自動で行う
- 指摘がある場合は、レビューコメントとして残す
- 修正した場合は、修正内容をコメントで明記する
- 修正しない場合は、修正しない理由をコメントで明記する
- 指摘対応後は再レビューを行う
- 問題がなければ `LGTM` コメントと approve を行ってから merge する
