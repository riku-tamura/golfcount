//
//  GolfCountViewModel.swift
//  GolfCountApp Watch App
//

import Combine
import Foundation

@MainActor
final class GolfCountViewModel: ObservableObject {
    @Published private(set) var session: GolfCountSession
    @Published var showsResetConfirmation = false
    @Published var showsFinishConfirmation = false

    private let repository: any GolfCountRepository

    init(repository: any GolfCountRepository) {
        self.repository = repository
        session = repository.loadSession()
    }

    var isRoundActive: Bool {
        session.isRoundActive
    }

    var summary: SummaryViewData {
        SummaryViewData(
            record: session.currentRecord,
            isGoalDisabled: !session.canFinishRound
        )
    }

    var startView: StartViewData {
        StartViewData(session: session)
    }

    var counters: [CounterViewData] {
        GolfCountMetric.allCases.map { CounterViewData(metric: $0, record: session.currentRecord) }
    }

    func startRound() {
        var updatedSession = session
        updatedSession.startRound()
        session = updatedSession
        repository.saveSession(session)
    }

    func increment(_ metric: GolfCountMetric) {
        guard session.isRoundActive else {
            return
        }

        update(metric, delta: 1)
    }

    func decrement(_ metric: GolfCountMetric) {
        guard session.isRoundActive else {
            return
        }

        update(metric, delta: -1)
    }

    func presentResetConfirmation() {
        guard session.isRoundActive else {
            return
        }

        showsResetConfirmation = true
    }

    func presentFinishConfirmation() {
        guard session.canFinishRound else {
            return
        }

        showsFinishConfirmation = true
    }

    func selectHole(_ holeNumber: Int) {
        guard session.isRoundActive else {
            return
        }

        guard holeNumber != session.currentRecord.selectedHoleNumber else {
            return
        }

        var updatedRecord = session.currentRecord
        updatedRecord.selectHole(holeNumber)
        session.currentRecord = updatedRecord
        repository.saveSession(session)
    }

    func reset() {
        session.currentRecord = .initial
        showsResetConfirmation = false
        repository.saveSession(session)
    }

    func finishRound() {
        var updatedSession = session

        guard updatedSession.finishRound() != nil else {
            return
        }

        session = updatedSession
        showsFinishConfirmation = false
        repository.saveSession(session)
    }

    private func update(_ metric: GolfCountMetric, delta: Int) {
        var updatedRecord = session.currentRecord
        updatedRecord.apply(delta: delta, for: metric)

        guard updatedRecord != session.currentRecord else {
            return
        }

        session.currentRecord = updatedRecord
        repository.saveSession(session)
    }
}
