//
//  ContentView.swift
//  GolfCountApp Watch App
//
//  Created by riku on 2026/04/01.
//

import SwiftUI

struct ContentView: View {
    private enum StorageKeys {
        static let finishedRound = "finishedRound"
    }

    @AppStorage(StorageKeys.finishedRound) private var persistedFinished = false
    @StateObject private var viewModel: GolfCountViewModel
    @State var started: Bool
    @State var finished: Bool
    @State private var showsFinishConfirmation = false

    init(viewModel: GolfCountViewModel) {
        let finishedRound = UserDefaults.standard.bool(forKey: StorageKeys.finishedRound)
        _viewModel = StateObject(wrappedValue: viewModel)
        _started = State(initialValue: finishedRound)
        _finished = State(initialValue: finishedRound)
    }

    var body: some View {
        ZStack {
            WatchDesign.screenBackground
                .ignoresSafeArea()

            if !started {
                StartView {
                    persistedFinished = false
                    started = true
                    finished = false
                }
            } else if finished {
                FinishView {
                    persistedFinished = false
                    viewModel.reset()
                    started = false
                    finished = false
                }
            } else {
                roundView
            }
        }
        .confirmationDialog("すべてのカウントを0に戻しますか？", isPresented: $viewModel.showsResetConfirmation) {
            Button("リセットする", role: .destructive) {
                persistedFinished = false
                viewModel.reset()
            }
        }
        .confirmationDialog("ラウンドを終了しますか？", isPresented: $showsFinishConfirmation) {
            Button("終了する") {
                persistedFinished = true
                finished = true
            }
        }
    }

    private var roundView: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: WatchDesign.sectionSpacing) {
                SummaryCardView(
                    summary: viewModel.summary,
                    onSelectHole: viewModel.selectHole
                )

                ForEach(viewModel.counters) { counter in
                    CounterCardView(
                        counter: counter,
                        onDecrement: { viewModel.decrement(counter.metric) },
                        onIncrement: { viewModel.increment(counter.metric) }
                    )
                }

                Button {
                    showsFinishConfirmation = true
                } label: {
                    Label("ラウンド終了", systemImage: "flag.checkered")
                        .frame(maxWidth: .infinity, minHeight: WatchDesign.buttonHeight)
                }
                .buttonStyle(.borderedProminent)
                .tint(canFinishRound ? .green : .gray)
                .disabled(!canFinishRound)

                Text(
                    canFinishRound
                    ? "入力内容を確認したら終了できます"
                    : "18ホールすべてに打数を入力すると終了できます"
                )
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.82))

                Button(role: .destructive) {
                    viewModel.presentResetConfirmation()
                } label: {
                    Label("リセット", systemImage: "arrow.counterclockwise")
                        .frame(maxWidth: .infinity, minHeight: WatchDesign.buttonHeight)
                }
                .buttonStyle(.bordered)
                .tint(.white.opacity(0.9))
            }
            .padding(.horizontal, WatchDesign.screenPadding)
            .padding(.vertical, 8)
        }
        .scrollIndicators(.hidden)
    }

    private var canFinishRound: Bool {
        viewModel.record.holes.allSatisfy { $0.strokes > 0 }
    }
}

private struct StartView: View {
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Spacer(minLength: 0)

            Text("GolfCount")
                .font(.headline.weight(.bold))
                .foregroundStyle(.white)

            Text("ラウンドを開始します")
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.82))

            Button(action: onStart) {
                Text("開始")
                    .frame(maxWidth: .infinity, minHeight: WatchDesign.buttonHeight)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, WatchDesign.screenPadding)
        .padding(.vertical, 8)
    }
}

private struct FinishView: View {
    let onClose: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Spacer(minLength: 0)

            Text("お疲れさまでした")
                .font(.headline.weight(.bold))
                .foregroundStyle(.white)

            Text("開始画面に戻ります")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.82))

            Button(action: onClose) {
                Text("開始画面へ戻る")
                    .frame(maxWidth: .infinity, minHeight: WatchDesign.buttonHeight)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, WatchDesign.screenPadding)
        .padding(.vertical, 8)
    }
}

#if DEBUG
#Preview {
    ContentView(viewModel: GolfCountViewModel(repository: InMemoryGolfCountRepository(record: .preview)))
}
#endif
