//
//  GolfCountRecord.swift
//  GolfCountApp Watch App
//

import Foundation

struct GolfCountRecord: Equatable, Codable {
    struct Hole: Equatable, Codable {
        private enum CodingKeys: String, CodingKey {
            case strokes
            case putts
            case penalty
        }

        var strokes: Int
        var putts: Int
        var penalty: Int

        init(strokes: Int, putts: Int, penalty: Int) {
            let normalizedStrokes = max(0, strokes)
            self.strokes = normalizedStrokes
            self.putts = max(0, min(putts, normalizedStrokes))
            self.penalty = max(0, penalty)
        }

        static let empty = Hole(strokes: 0, putts: 0, penalty: 0)

        var totalScore: Int {
            strokes + penalty
        }

        mutating func updateStrokes(by delta: Int) {
            strokes = max(0, strokes + delta)
            putts = min(putts, strokes)
        }

        mutating func updatePutts(by delta: Int) {
            putts = max(0, min(putts + delta, strokes))
        }

        mutating func updatePenalty(by delta: Int) {
            penalty = max(0, penalty + delta)
        }

        init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let strokes = try container.decode(Int.self, forKey: .strokes)
            let putts = try container.decode(Int.self, forKey: .putts)
            let penalty = try container.decode(Int.self, forKey: .penalty)

            self.init(strokes: strokes, putts: putts, penalty: penalty)
        }
    }

    private enum CodingKeys: String, CodingKey {
        case selectedHoleNumber
        case holes
    }

    static let holeCount = 18
    static let availableHoleNumbers = Array(1...holeCount)

    var selectedHoleNumber: Int
    var holes: [Hole]

    static let initial = GolfCountRecord(
        selectedHoleNumber: 1,
        holes: Array(repeating: .empty, count: holeCount)
    )

    init(selectedHoleNumber: Int, holes: [Hole]) {
        let normalizedHoles = holes.prefix(Self.holeCount).map {
            Hole(strokes: $0.strokes, putts: $0.putts, penalty: $0.penalty)
        }
        let paddedHoles = Array(normalizedHoles)
        self.holes = paddedHoles + Array(repeating: .empty, count: max(0, Self.holeCount - paddedHoles.count))
        self.selectedHoleNumber = min(max(1, selectedHoleNumber), Self.holeCount)
    }

    var totalScore: Int {
        holes.reduce(0) { $0 + $1.totalScore }
    }

    var selectedHoleLabel: String {
        "\(selectedHoleNumber)H"
    }

    var currentHole: Hole {
        holes[selectedHoleIndex]
    }

    func hole(at holeNumber: Int) -> Hole {
        let normalizedHoleNumber = min(max(1, holeNumber), Self.holeCount)
        return holes[normalizedHoleNumber - 1]
    }

    mutating func selectHole(_ holeNumber: Int) {
        selectedHoleNumber = min(max(1, holeNumber), Self.holeCount)
    }

    mutating func apply(delta: Int, for metric: GolfCountMetric) {
        var hole = currentHole
        metric.applying(delta: delta, to: &hole)
        holes[selectedHoleIndex] = hole
    }

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let selectedHoleNumber = try container.decode(Int.self, forKey: .selectedHoleNumber)
        let holes = try container.decode([Hole].self, forKey: .holes)

        self.init(selectedHoleNumber: selectedHoleNumber, holes: holes)
    }

    private var selectedHoleIndex: Int {
        selectedHoleNumber - 1
    }
}

#if DEBUG
extension GolfCountRecord {
    static let preview: GolfCountRecord = {
        var holes = Array(repeating: Hole.empty, count: holeCount)
        holes[0] = Hole(strokes: 4, putts: 2, penalty: 0)
        holes[1] = Hole(strokes: 5, putts: 2, penalty: 1)
        holes[2] = Hole(strokes: 3, putts: 1, penalty: 0)
        holes[6] = Hole(strokes: 4, putts: 2, penalty: 1)
        return GolfCountRecord(selectedHoleNumber: 7, holes: holes)
    }()
}
#endif
