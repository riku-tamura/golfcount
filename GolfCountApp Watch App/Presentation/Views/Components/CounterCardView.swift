//
//  CounterCardView.swift
//  GolfCountApp Watch App
//

import SwiftUI

struct CounterCardView: View {
    let counter: CounterViewData
    let onDecrement: () -> Void
    let onIncrement: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(counter.title)
                .font(.headline)
                .foregroundStyle(.white)

            if let subtitle = counter.subtitle {
                Text(subtitle)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }

            Text(counter.valueText)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .monospacedDigit()
                .contentTransition(.numericText())
                .frame(maxWidth: .infinity, minHeight: WatchDesign.valuePanelHeight)
                .background(
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(WatchDesign.valueBackground)
                )
                .accessibilityLabel(counter.valueAccessibilityLabel)

            HStack(spacing: 10) {
                CountButtonView(
                    systemImage: "minus",
                    title: counter.decrementButtonText,
                    accessibilityLabel: counter.decrementAccessibilityLabel,
                    tint: .red,
                    action: onDecrement
                )
                .disabled(counter.isDecrementDisabled)

                CountButtonView(
                    systemImage: "plus",
                    title: counter.incrementButtonText,
                    accessibilityLabel: counter.incrementAccessibilityLabel,
                    tint: .green,
                    action: onIncrement
                )
                .disabled(counter.isIncrementDisabled)
            }
        }
        .padding(WatchDesign.cardPadding)
        .background(
            RoundedRectangle(cornerRadius: WatchDesign.cardCornerRadius, style: .continuous)
                .fill(WatchDesign.cardBackground)
        )
        .overlay {
            RoundedRectangle(cornerRadius: WatchDesign.cardCornerRadius, style: .continuous)
                .stroke(.white.opacity(0.08), lineWidth: 1)
        }
    }
}

private struct CountButtonView: View {
    let systemImage: String
    let title: String
    let accessibilityLabel: String
    let tint: Color
    let action: () -> Void

    var body: some View {
        Button {
            WatchHaptics.play(.click)
            action()
        } label: {
            VStack(spacing: 2) {
                Image(systemName: systemImage)
                    .font(.headline.weight(.bold))

                Text(title)
                    .font(.caption2.weight(.bold))
                    .monospacedDigit()
            }
            .frame(maxWidth: .infinity, minHeight: WatchDesign.buttonHeight)
        }
        .buttonStyle(.borderedProminent)
        .tint(tint)
        .accessibilityLabel(accessibilityLabel)
    }
}
