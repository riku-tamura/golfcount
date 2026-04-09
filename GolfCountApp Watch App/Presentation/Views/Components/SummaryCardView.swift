//
//  SummaryCardView.swift
//  GolfCountApp Watch App
//

import SwiftUI

struct SummaryCardView: View {
    let summary: SummaryViewData
    let onSelectHole: (Int) -> Void
    let onFinishRound: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center) {
                Text(summary.scoreTitle)
                    .font(.caption.weight(.black))
                    .foregroundStyle(.white.opacity(0.94))

                Spacer()

                Text(summary.scoreScopeText)
                    .font(.caption2.weight(.bold))
                    .foregroundStyle(.white.opacity(0.82))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(.white.opacity(0.14), in: Capsule())
            }

            Text(summary.totalScoreText)
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .monospacedDigit()
                .contentTransition(.numericText())
                .frame(maxWidth: .infinity, minHeight: 76)
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(WatchDesign.valueBackground)
                )
                .accessibilityLabel(summary.totalAccessibilityLabel)

            Picker(
                summary.holeSelectionLabel,
                selection: Binding(
                    get: { summary.selectedHoleNumber },
                    set: { holeNumber in
                        guard holeNumber != summary.selectedHoleNumber else {
                            return
                        }

                        WatchHaptics.play(.click)

                        Task { @MainActor in
                            onSelectHole(holeNumber)
                        }
                    }
                )
            ) {
                ForEach(summary.holeOptions) { option in
                    Text(option.title)
                        .foregroundStyle(option.isEntered ? WatchDesign.enteredHoleColor : .white)
                        .tag(option.holeNumber)
                        .accessibilityLabel(option.accessibilityLabel)
                }
            }
            .pickerStyle(.navigationLink)
            .tint(.white)
            .accessibilityLabel(summary.holeSelectionLabel)

            Button {
                WatchHaptics.play(.click)
                onFinishRound()
            } label: {
                Label(summary.goalButtonTitle, systemImage: "flag.checkered.circle.fill")
                    .font(.footnote.weight(.bold))
                    .frame(maxWidth: .infinity, minHeight: WatchDesign.buttonHeight - 4)
            }
            .buttonStyle(.borderedProminent)
            .tint(.white.opacity(0.18))
            .disabled(summary.isGoalDisabled)
            .accessibilityLabel(summary.goalButtonAccessibilityLabel)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(WatchDesign.cardPadding)
        .background(
            RoundedRectangle(cornerRadius: WatchDesign.cardCornerRadius, style: .continuous)
                .fill(WatchDesign.summaryBackground)
        )
        .overlay {
            RoundedRectangle(cornerRadius: WatchDesign.cardCornerRadius, style: .continuous)
                .stroke(.white.opacity(0.08), lineWidth: 1)
        }
    }
}
