//
//  SummaryViewData.swift
//  GolfCountApp Watch App
//

import Foundation

struct SummaryViewData {
    let appName: String
    let totalScoreText: String
    let totalDescription: String
    let holeLabel: String
    let persistenceLabel: String
    let nextHoleTitle: String
    let nextHoleDescription: String
    let isNextHoleDisabled: Bool

    init(record: GolfCountRecord) {
        appName = "GolfCount"
        totalScoreText = "\(record.totalScore)"
        totalDescription = "打数 + ペナルティ"
        holeLabel = "Hole \(record.holeNumber)"
        persistenceLabel = "Watch内のみ保存"
        nextHoleTitle = "次のホールへ"
        nextHoleDescription = "ホールを進めてカウントを0に戻す"
        isNextHoleDisabled = !record.canAdvanceHole
    }
}
