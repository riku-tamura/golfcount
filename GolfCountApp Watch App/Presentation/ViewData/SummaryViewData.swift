//
//  SummaryViewData.swift
//  GolfCountApp Watch App
//

import Foundation

struct SummaryViewData {
    let scoreTitle: String
    let scoreScopeText: String
    let totalScoreText: String
    let totalAccessibilityLabel: String
    let holeSelectionLabel: String
    let availableHoleNumbers: [Int]
    let selectedHoleNumber: Int

    init(record: GolfCountRecord) {
        scoreTitle = "スコア"
        scoreScopeText = "18H合計"
        totalScoreText = "\(record.totalScore)"
        totalAccessibilityLabel = "18ホール合計 \(record.totalScore)"
        holeSelectionLabel = "ホール"
        availableHoleNumbers = GolfCountRecord.availableHoleNumbers
        selectedHoleNumber = record.selectedHoleNumber
    }
}
