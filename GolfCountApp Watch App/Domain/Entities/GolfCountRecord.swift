//
//  GolfCountRecord.swift
//  GolfCountApp Watch App
//

import Foundation

struct GolfCountRecord: Equatable, Codable {
    struct Hole: Equatable, Codable {
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

    var hasEnteredData: Bool {
        holes.contains { $0.strokes >= 1 }
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

    private var selectedHoleIndex: Int {
        selectedHoleNumber - 1
    }
}

struct GolfCountCompletedRound: Identifiable, Equatable, Codable {
    let id: UUID
    let startedAt: Date
    let finishedAt: Date
    let holes: [GolfCountRecord.Hole]

    init(
        id: UUID = UUID(),
        startedAt: Date,
        finishedAt: Date,
        holes: [GolfCountRecord.Hole]
    ) {
        self.id = id
        self.startedAt = startedAt
        self.finishedAt = finishedAt
        self.holes = Array(holes.prefix(GolfCountRecord.holeCount))
            + Array(repeating: .empty, count: max(0, GolfCountRecord.holeCount - holes.count))
    }

    var totalScore: Int {
        holes.reduce(0) { $0 + $1.totalScore }
    }
}

struct GolfCountSession: Equatable, Codable {
    var currentRecord: GolfCountRecord
    var isRoundActive: Bool
    var currentRoundStartedAt: Date?
    var completedRounds: [GolfCountCompletedRound]

    static let initial = GolfCountSession(
        currentRecord: .initial,
        isRoundActive: false,
        currentRoundStartedAt: nil,
        completedRounds: []
    )

    var canFinishRound: Bool {
        isRoundActive && currentRecord.hasEnteredData
    }

    var latestCompletedRound: GolfCountCompletedRound? {
        completedRounds.first
    }

    mutating func startRound(at date: Date = Date()) {
        currentRecord = .initial
        isRoundActive = true
        currentRoundStartedAt = date
    }

    mutating func finishRound(at date: Date = Date()) -> GolfCountCompletedRound? {
        guard isRoundActive else {
            return nil
        }

        let completedRound = GolfCountCompletedRound(
            startedAt: currentRoundStartedAt ?? date,
            finishedAt: date,
            holes: currentRecord.holes
        )

        completedRounds.insert(completedRound, at: 0)
        currentRecord = .initial
        isRoundActive = false
        currentRoundStartedAt = nil
        return completedRound
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

extension GolfCountSession {
    static let preview = GolfCountSession(
        currentRecord: .preview,
        isRoundActive: true,
        currentRoundStartedAt: Date(timeIntervalSince1970: 1_744_049_600),
        completedRounds: [
            GolfCountCompletedRound(
                startedAt: Date(timeIntervalSince1970: 1_744_020_800),
                finishedAt: Date(timeIntervalSince1970: 1_744_025_200),
                holes: GolfCountRecord.preview.holes
            )
        ]
    )
}
#endif
