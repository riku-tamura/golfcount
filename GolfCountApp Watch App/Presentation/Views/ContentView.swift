//
//  ContentView.swift
//  GolfCountApp Watch App
//
//  Created by riku on 2026/04/01.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: GolfCountViewModel

    init(viewModel: GolfCountViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack {
            WatchDesign.screenBackground
                .ignoresSafeArea()

            if viewModel.isRoundActive {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: WatchDesign.sectionSpacing) {
                        SummaryCardView(
                            summary: viewModel.summary,
                            onSelectHole: viewModel.selectHole,
                            onFinishRound: viewModel.presentFinishConfirmation
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
            } else {
                StartRoundView(
                    startView: viewModel.startView,
                    onStart: viewModel.startRound
                )
                .padding(.horizontal, WatchDesign.screenPadding)
            }
        }
        .confirmationDialog("すべてのカウントを0に戻しますか？", isPresented: $viewModel.showsResetConfirmation) {
            Button("リセットする", role: .destructive) {
                viewModel.reset()
            }
        }
        .confirmationDialog("ラウンドを終了して保存しますか？", isPresented: $viewModel.showsFinishConfirmation) {
            Button("保存して終了", role: .destructive) {
                WatchHaptics.play(.success)
                viewModel.finishRound()
            }
        }
    }
}

private struct StartRoundView: View {
    let startView: StartViewData
    let onStart: () -> Void

    var body: some View {
        VStack(spacing: WatchDesign.sectionSpacing) {
            Spacer(minLength: 0)

            VStack(spacing: 10) {
                Text(startView.title)
                    .font(.headline.weight(.black))
                    .foregroundStyle(.white)

                Text(startView.subtitle)
                    .font(.footnote)
                    .foregroundStyle(.white.opacity(0.78))
                    .multilineTextAlignment(.center)

                if let latestRoundText = startView.latestRoundText {
                    Text(latestRoundText)
                        .font(.subheadline.weight(.bold))
                        .foregroundStyle(.white)
                }

                if let savedRoundCountText = startView.savedRoundCountText {
                    Text(savedRoundCountText)
                        .font(.caption)
                        .foregroundStyle(.white.opacity(0.72))
                }
            }
            .frame(maxWidth: .infinity)
            .padding(WatchDesign.cardPadding)
            .background(
                RoundedRectangle(cornerRadius: WatchDesign.cardCornerRadius, style: .continuous)
                    .fill(WatchDesign.summaryBackground)
            )

            Button {
                WatchHaptics.play(.start)
                onStart()
            } label: {
                Label(startView.startButtonTitle, systemImage: "play.circle.fill")
                    .font(.headline.weight(.bold))
                    .frame(maxWidth: .infinity, minHeight: WatchDesign.buttonHeight)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)

            Spacer(minLength: 0)
        }
    }
}

#if DEBUG
#Preview {
    ContentView(viewModel: GolfCountViewModel(repository: InMemoryGolfCountRepository(session: .preview)))
}
#endif
