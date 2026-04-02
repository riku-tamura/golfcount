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
        .confirmationDialog("すべてのカウントを0に戻しますか？", isPresented: $viewModel.showsResetConfirmation) {
            Button("リセットする", role: .destructive) {
                viewModel.reset()
            }
        }
    }
}

#if DEBUG
#Preview {
    ContentView(viewModel: GolfCountViewModel(repository: InMemoryGolfCountRepository(record: .preview)))
}
#endif
