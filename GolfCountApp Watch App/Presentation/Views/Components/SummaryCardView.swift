//
//  SummaryCardView.swift
//  GolfCountApp Watch App
//

import SwiftUI

struct SummaryCardView: View {
    let summary: SummaryViewData
    let onAdvanceHole: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text(summary.appName)
                        .font(.headline)

                    Text(summary.persistenceLabel)
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(.white.opacity(0.8))
                }

                Spacer()

                Text(summary.holeLabel)
                    .font(.caption.weight(.bold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.white.opacity(0.16), in: Capsule())
            }

            HStack(alignment: .lastTextBaseline, spacing: 6) {
                Text(summary.totalScoreText)
                    .font(.system(.largeTitle, design: .rounded).weight(.bold))
                    .monospacedDigit()
                    .contentTransition(.numericText())

                Text("合計")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white.opacity(0.86))
            }

            Text(summary.totalDescription)
                .font(.footnote)
                .foregroundStyle(.white.opacity(0.76))

            Button {
                WatchHaptics.play(.success)
                onAdvanceHole()
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: "flag.checkered.circle.fill")
                    Text(summary.nextHoleTitle)
                }
                .font(.footnote.weight(.bold))
                .frame(maxWidth: .infinity, minHeight: WatchDesign.buttonHeight - 4)
            }
            .buttonStyle(.borderedProminent)
            .tint(.white.opacity(0.18))
            .disabled(summary.isNextHoleDisabled)
            .accessibilityLabel(summary.nextHoleTitle)
            .accessibilityHint(summary.nextHoleDescription)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(WatchDesign.cardPadding)
        .background(
            RoundedRectangle(cornerRadius: WatchDesign.cardCornerRadius, style: .continuous)
                .fill(WatchDesign.summaryBackground)
        )
    }
}
