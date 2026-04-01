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
    let undoAdvanceTitle: String
    let undoAdvanceDescription: String
    let isNextHoleDisabled: Bool
    let showsUndoAdvance: Bool

    init(record: GolfCountRecord, canUndoAdvance: Bool) {
        appName = "GolfCount"
        totalScoreText = "\(record.totalScore)"
        totalDescription = "打数 + ペナルティ"
        holeLabel = "Hole \(record.holeNumber)"
        persistenceLabel = "Watch内のみ保存"
        nextHoleTitle = "次のホールへ"
        nextHoleDescription = "ホールを進めてカウントを0に戻す"
        undoAdvanceTitle = "1つ戻す"
        undoAdvanceDescription = "直前のホール移動を取り消して元の値に戻す"
        isNextHoleDisabled = !record.canAdvanceHole
        showsUndoAdvance = canUndoAdvance
    }
}
