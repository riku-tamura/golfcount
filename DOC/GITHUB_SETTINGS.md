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
    - 1人運用の間は OFF
    - レビュー運用を始めたら 1 以上
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
4. PR は squash merge する
5. merge 後は branch を削除する
6. CI が安定したら `watchos-build` を必須チェックにする

## PR タイトルのおすすめ

- `Add undo action for accidental next-hole taps`
- `Add par input to the watch counter`
- `Refine Apple Watch counter accessibility`

## PR 本文で最低限そろえる項目

- 何を変えたか
- なぜ必要か
- 影響範囲
- 手元で確認した内容
- 未確認のリスク

## 追加済みの GitHub ファイル

- `.github/pull_request_template.md`
  - PR 作成時にチェック観点を統一する
- `.github/workflows/watchos-build.yml`
  - PR と push で Watch アプリのビルド確認を走らせる
