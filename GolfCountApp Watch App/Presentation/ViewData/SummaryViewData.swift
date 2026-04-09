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
    let goalButtonTitle: String
    let goalButtonAccessibilityLabel: String
    let isGoalDisabled: Bool

    init(record: GolfCountRecord, isGoalDisabled: Bool) {
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
        goalButtonTitle = "ゴール"
        goalButtonAccessibilityLabel = "ラウンドを終了して保存する"
        self.isGoalDisabled = isGoalDisabled
    }
}

struct StartViewData {
    let title: String
    let subtitle: String
    let startButtonTitle: String
    let latestRoundText: String?
    let savedRoundCountText: String?

    init(session: GolfCountSession) {
        title = "GolfCount"
        subtitle = "スタートして記録を始めます"
        startButtonTitle = "スタート"

        if let latestRound = session.latestCompletedRound {
            latestRoundText = "前回スコア \(latestRound.totalScore)"
            savedRoundCountText = "保存済み \(session.completedRounds.count) ラウンド"
        } else {
            latestRoundText = nil
            savedRoundCountText = nil
        }
    }
}
