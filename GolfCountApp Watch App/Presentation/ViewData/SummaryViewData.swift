//
//  SummaryViewData.swift
//  GolfCountApp Watch App
//

import Foundation

struct SummaryViewData {
    struct HoleOption: Identifiable {
        let holeNumber: Int
        let isEntered: Bool

        var id: Int { holeNumber }
        var title: String { "\(holeNumber)H" }
        var accessibilityLabel: String {
            "\(holeNumber)ホール \(isEntered ? "入力済み" : "未入力")"
        }
    }

    let scoreTitle: String
    let scoreScopeText: String
    let totalScoreText: String
    let totalAccessibilityLabel: String
    let holeSelectionLabel: String
    let holeOptions: [HoleOption]
    let selectedHoleNumber: Int

    init(record: GolfCountRecord) {
        scoreTitle = "スコア"
        scoreScopeText = "18H合計"
        totalScoreText = "\(record.totalScore)"
        totalAccessibilityLabel = "18ホール合計 \(record.totalScore)"
        holeSelectionLabel = "ホール"
        holeOptions = GolfCountRecord.availableHoleNumbers.map { holeNumber in
            HoleOption(
                holeNumber: holeNumber,
                isEntered: record.hole(at: holeNumber).strokes >= 1
            )
        }
        selectedHoleNumber = record.selectedHoleNumber
    }
}
