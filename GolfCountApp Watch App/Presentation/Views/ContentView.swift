//
//  ContentView.swift
//  GolfCountApp Watch App
//
//  Created by riku on 2026/04/01.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: GolfCountViewModel
    @State var started = false
    @State var finished = false

    init(viewModel: GolfCountViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            WatchDesign.screenBackground
                .ignoresSafeArea()

            if !started {
                StartView {
                    started = true
                    finished = false
                }
            } else if finished {
                FinishView {
                    started = false
                    finished = false
                }
            } else {
                roundView
            }
        }
        .confirmationDialog("すべてのカウントを0に戻しますか？", isPresented: $viewModel.showsResetConfirmation) {
            Button("リセットする", role: .destructive) {
                viewModel.reset()
            }
        }
        .onChange(of: viewModel.record) { _, record in
            guard started, !finished else {
                return
            }

            finished = record.holes.allSatisfy { $0.strokes > 0 }
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
    let onSave: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Spacer(minLength: 0)

            Text("ラウンド終了")
                .font(.headline.weight(.bold))
                .foregroundStyle(.white)

            Text("保存して開始画面へ戻ります")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .foregroundStyle(.white.opacity(0.82))

            Button(action: onSave) {
                Text("保存")
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
