//
//  GolfCountRecord.swift
//  GolfCountApp Watch App
//

import Foundation

struct GolfCountRecord: Equatable {
    var holeNumber: Int
    var strokes: Int
    var penalty: Int
    var putts: Int

    static let initial = GolfCountRecord(holeNumber: 1, strokes: 0, penalty: 0, putts: 0)

    var totalScore: Int {
        strokes + penalty
    }

    var canAdvanceHole: Bool {
        holeNumber < 18
    }

    func advancingToNextHole() -> GolfCountRecord {
        guard canAdvanceHole else {
            return self
        }

        return GolfCountRecord(
            holeNumber: holeNumber + 1,
            strokes: 0,
            penalty: 0,
            putts: 0
        )
    }
}

#if DEBUG
extension GolfCountRecord {
    static let preview = GolfCountRecord(holeNumber: 7, strokes: 4, penalty: 1, putts: 2)
}
#endif
