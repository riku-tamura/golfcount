//
//  GolfCountMetric.swift
//  GolfCountApp Watch App
//

import Foundation

enum GolfCountMetric: CaseIterable, Identifiable {
    case holeNumber
    case strokes
    case penalty
    case putts

    var id: Self { self }

    var title: String {
        switch self {
        case .holeNumber:
            return "ホール"
        case .strokes:
            return "打数"
        case .penalty:
            return "ペナルティ"
        case .putts:
            return "パット"
        }
    }

    var subtitle: String {
        switch self {
        case .holeNumber:
            return "1〜18"
        case .strokes:
            return "ショット数"
        case .penalty:
            return "加算分"
        case .putts:
            return "グリーン上"
        }
    }

    var minimumValue: Int {
        switch self {
        case .holeNumber:
            return 1
        case .strokes, .penalty, .putts:
            return 0
        }
    }

    var maximumValue: Int? {
        switch self {
        case .holeNumber:
            return 18
        case .strokes, .penalty, .putts:
            return nil
        }
    }

    func value(in record: GolfCountRecord) -> Int {
        switch self {
        case .holeNumber:
            return record.holeNumber
        case .strokes:
            return record.strokes
        case .penalty:
            return record.penalty
        case .putts:
            return record.putts
        }
    }

    func applying(delta: Int, to record: inout GolfCountRecord) {
        let nextValue = boundedValue(from: value(in: record) + delta)

        switch self {
        case .holeNumber:
            record.holeNumber = nextValue
        case .strokes:
            record.strokes = nextValue
        case .penalty:
            record.penalty = nextValue
        case .putts:
            record.putts = nextValue
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
