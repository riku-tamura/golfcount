# Structure

## フォルダ構成

### `GolfCountApp Watch App/App`

- アプリの起動点と依存関係の組み立てを置くフォルダ

### `GolfCountApp Watch App/Domain`

- 画面や保存方式に依存しないアプリのルールを置くフォルダ

### `GolfCountApp Watch App/Data`

- 永続化や外部入出力の実装を置くフォルダ

### `GolfCountApp Watch App/Presentation`

- 画面表示、表示用データ、ユーザー操作をまとめるフォルダ

### `GolfCountApp Watch App/Assets.xcassets`

- App Icon やアクセントカラーなどのアセットを置くフォルダ

### `DOC`

- 構成説明、設計意図、UI 方針を残すフォルダ

### `.github`

- GitHub の PR 運用に使うテンプレートや設定ファイルを置くフォルダ

## ファイルごとの役割

### App

- `GolfCountApp Watch App/App/GolfCountAppApp.swift`
  - Apple Watch アプリのエントリポイント
- `GolfCountApp Watch App/App/AppDependencyContainer.swift`
  - Repository と ViewModel の組み立てを担当する簡易 DI コンテナ

### Domain

- `GolfCountApp Watch App/Domain/Entities/GolfCountRecord.swift`
  - ホール、打数、ペナルティ、パットの状態を表す Entity
- `GolfCountApp Watch App/Domain/Entities/GolfCountMetric.swift`
  - カウント対象ごとの表示名、範囲制約、更新ルールを表す定義

### Data

- `GolfCountApp Watch App/Data/Repositories/GolfCountRepository.swift`
  - 保存と読込の抽象インターフェース
- `GolfCountApp Watch App/Data/Repositories/UserDefaultsGolfCountRepository.swift`
  - `UserDefaults` を使って Watch 内だけに状態を保存する実装
- `GolfCountApp Watch App/Data/Repositories/InMemoryGolfCountRepository.swift`
  - Preview 用のメモリ上 Repository

### Presentation

- `GolfCountApp Watch App/Presentation/ViewModels/GolfCountViewModel.swift`
  - 画面状態の保持、加算減算、リセット、保存トリガを担当
- `GolfCountApp Watch App/Presentation/ViewData/SummaryViewData.swift`
  - サマリーカード表示用データ
- `GolfCountApp Watch App/Presentation/ViewData/CounterViewData.swift`
  - カウンターカード表示用データ
- `GolfCountApp Watch App/Presentation/Support/WatchHaptics.swift`
  - Apple Watch の触覚フィードバック呼び出しをまとめる補助ファイル
- `GolfCountApp Watch App/Presentation/Views/ContentView.swift`
  - 画面全体のレイアウトと操作の接続を担当
- `GolfCountApp Watch App/Presentation/Views/Components/SummaryCardView.swift`
  - 合計とホール情報の表示コンポーネント
- `GolfCountApp Watch App/Presentation/Views/Components/CounterCardView.swift`
  - 各項目の `+1 / -1` 操作コンポーネント
- `GolfCountApp Watch App/Presentation/Style/WatchDesign.swift`
  - 余白、角丸、背景色、ボタン高など UI 定数

### Project Root

- `.gitignore`
  - ビルド生成物や `.DS_Store` を Git 管理から外す設定
- `DOC/NEXT_ACTIONS.md`
  - 実機での確認事項と次に着手すべき内容の整理
- `DOC/GITHUB_SETTINGS.md`
  - GitHub で有効にしたい推奨設定と PR 運用手順
- `.github/pull_request_template.md`
  - PR 作成時に確認観点を揃えるためのテンプレート

## 変更時の目安

- 見た目だけを変える
  - `Presentation/Views` と `Presentation/Style`
- 表示文言や表示用の整形を変える
  - `Presentation/ViewData`
- カウントルールや制約を変える
  - `Domain`
- 保存先を変える
  - `Data/Repositories`
- 起動時の依存関係を変える
  - `App`
