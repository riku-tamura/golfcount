//
//  GolfCountMetric.swift
//  GolfCountApp Watch App
//

import Foundation

enum GolfCountMetric: CaseIterable, Identifiable {
    case strokes
    case putts
    case penalty

    var id: Self { self }

    var title: String {
        switch self {
        case .strokes:
            return "打数"
        case .putts:
            return "パット"
        case .penalty:
            return "ペナルティ"
        }
    }

    var subtitle: String? {
        switch self {
        case .strokes:
            return nil
        case .putts:
            return nil
        case .penalty:
            return nil
        }
    }

    var minimumValue: Int {
        switch self {
        case .strokes, .putts, .penalty:
            return 0
        }
    }

    var maximumValue: Int? {
        switch self {
        case .strokes, .penalty:
            return nil
        case .putts:
            return nil
        }
    }

    func maximumValue(in record: GolfCountRecord) -> Int? {
        switch self {
        case .strokes, .penalty:
            return maximumValue
        case .putts:
            return record.currentHole.strokes
        }
    }

    func value(in record: GolfCountRecord) -> Int {
        switch self {
        case .strokes:
            return record.currentHole.strokes
        case .putts:
            return record.currentHole.putts
        case .penalty:
            return record.currentHole.penalty
        }
    }

    func applying(delta: Int, to hole: inout GolfCountRecord.Hole) {
        switch self {
        case .strokes:
            hole.updateStrokes(by: delta)
        case .putts:
            hole.updatePutts(by: delta)
        case .penalty:
            hole.updatePenalty(by: delta)
        }
    }

    private func boundedValue(from candidate: Int) -> Int {
        let lowerBounded = max(minimumValue, candidate)

        guard let maximumValue else {
            return lowerBounded
        }

        return min(maximumValue, lowerBounded)
    }
}
