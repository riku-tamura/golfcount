# GitHub Settings

## まず設定したい項目

### General

- Description
  - `Apple Watch用のゴルフカウントアプリ`
- Website
  - 必要になるまで空でよい
- Features
  - `Issues`: ON
  - `Projects`: OFF でもよい
  - `Wiki`: OFF 推奨
  - `Discussions`: OFF でもよい

### Pull Requests

- Allow merge commits
  - OFF 推奨
- Allow squash merging
  - ON 推奨
- Allow rebase merging
  - OFF 推奨
- Always suggest updating pull request branches
  - ON 推奨
- Automatically delete head branches
  - ON 推奨

### Branch Protection

- 対象ブランチ
  - `main`
- 推奨ルール
  - `Require a pull request before merging`: ON
  - `Require approvals`
    - GitHub 上で厳密に強制する場合は 1 以上
    - ただし 1人運用や同一アカウントでのレビューでは運用と噛み合わないことがあるので注意
  - `Dismiss stale pull request approvals when new commits are pushed`: ON
  - `Require status checks to pass before merging`
    - `watchos-build` ワークフロー導入後は ON 推奨
  - `Require conversation resolution before merging`: ON
  - `Restrict pushes that create files larger than 100 MB`: ON
  - `Do not allow bypassing the above settings`: 1人運用の間は OFF

## このリポジトリでのおすすめ運用

1. `main` には直接コミットしない
2. 作業ごとに `codex/...` か `feature/...` ブランチを切る
3. push 後に PR を作る
4. PR 作成時と更新時に `@codex 日本語でレビューしてください` を自動投稿して Codex レビューを依頼する
5. PR 作成後に必ずレビューを行う
6. 指摘があればレビューコメントとして残す
7. 修正が必要なら、先に実際の修正対応を行う
8. 修正したら「対応しました」と内容をコメントで残す
9. 修正しないなら「今回は対応しません」と理由をコメントで残す
10. 指摘対応後に再レビューを行う
11. 問題がなければ `LGTM` コメントを残して `approve` する
12. その後に squash merge する
13. merge 後は branch を削除する
14. CI が安定したら `watchos-build` を必須チェックにする

## PR タイトルのおすすめ

- `次ホール誤操作の戻し導線を追加する`
- `Apple Watch カウンターにパー入力を追加する`
- `Apple Watch カウンターのアクセシビリティを改善する`

## PR 本文で最低限そろえる項目

- 何を変えたか
- なぜ必要か
- 影響範囲
- 手元で確認した内容
- 未確認のリスク
- レビュー対応の前提

## レビューコメント運用

- `chatgpt-codex-connector` へのレビュー依頼は `.github/workflows/codex-review-request.yml` で自動化する
- 指摘はレビューコメントとして残す
- 修正が必要な場合は、先に実際の修正対応を行う
- 修正した場合は、修正内容をコメントとして残す
- 修正しない場合は、採用しない理由をコメントとして残す
- 対応後は再レビューする
- 最終的に問題がなければ `LGTM` コメントを残し、`approve` してから merge する

詳しい流れは `DOC/PR_REVIEW_FLOW.md` を参照する

## 追加済みの GitHub ファイル

- `.github/pull_request_template.md`
  - PR 作成時にチェック観点を統一する
- `.github/workflows/watchos-build.yml`
  - PR と push で Watch アプリのビルド確認を走らせる
- `.github/workflows/codex-review-request.yml`
  - PR 作成時と更新時に `@codex 日本語でレビューしてください` コメントを自動投稿して Codex レビューを依頼する
- `DOC/PR_REVIEW_FLOW.md`
  - PR 作成後のレビュー、修正対応、再レビュー、承認、merge の手順を整理する
