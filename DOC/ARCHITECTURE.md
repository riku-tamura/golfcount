# Architecture

## 採用方針

このアプリは小規模ですが、責務が View に集中しないよう、一般的な layered MVVM に寄せています。

- `App`
  - 依存関係の組み立てと起動点を担当
- `Presentation`
  - 画面描画、表示用データ、画面操作の受け口を担当
- `Domain`
  - カウント対象、制約、集計ルールなどの中核ルールを担当
- `Data`
  - 永続化の実装を担当

## 依存方向

依存は次の向きだけにしています。

`App -> Presentation -> Domain`

`Presentation -> Data(Protocol経由)`

`Data -> Domain`

ポイント:

- View は保存方法を知りません
- ViewModel は `UserDefaults` を直接触りません
- Domain は UI や永続化の詳細を知りません

## データフロー

1. `GolfCountAppApp` が `AppDependencyContainer` を生成する
2. `AppDependencyContainer` が `GolfCountViewModel` に `GolfCountRepository` 実装を渡す
3. `GolfCountViewModel` が起動時に保存済みデータを読み込む
4. View は `SummaryViewData` / `CounterViewData` を描画する
5. ボタン操作時は ViewModel が Domain ルールで値を更新する
6. 更新後の状態を Repository が保存する

## なぜこの構成か

- 画面を変えても保存処理に影響しにくい
- 保存方式を変えても View を壊しにくい
- 小さいアプリでも、今後の機能追加時に修正箇所を絞りやすい

## 今後の拡張ポイント

- 履歴保存を追加する場合
  - `Data` に履歴用 Repository を追加
  - `Domain` にラウンド単位の Entity を追加
- 統計表示を追加する場合
  - `Presentation` に別 ViewModel / View を追加
- 永続化を `SwiftData` や `FileManager` に変える場合
  - `GolfCountRepository` 実装だけ差し替える
