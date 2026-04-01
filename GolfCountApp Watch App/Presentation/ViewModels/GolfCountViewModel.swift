//
//  GolfCountViewModel.swift
//  GolfCountApp Watch App
//

import Combine
import Foundation

@MainActor
final class GolfCountViewModel: ObservableObject {
    @Published private(set) var record: GolfCountRecord
    @Published var showsResetConfirmation = false

    private let repository: any GolfCountRepository
    private var lastAdvancedRecord: GolfCountRecord?

    init(repository: any GolfCountRepository) {
        self.repository = repository
        record = repository.loadRecord()
    }

    var summary: SummaryViewData {
        SummaryViewData(record: record, canUndoAdvance: lastAdvancedRecord != nil)
    }

    var counters: [CounterViewData] {
        GolfCountMetric.allCases.map { CounterViewData(metric: $0, record: record) }
    }

    func increment(_ metric: GolfCountMetric) {
        update(metric, delta: 1)
    }

    func decrement(_ metric: GolfCountMetric) {
        update(metric, delta: -1)
    }

    func presentResetConfirmation() {
        showsResetConfirmation = true
    }

    func advanceToNextHole() {
        let updatedRecord = record.advancingToNextHole()

        guard updatedRecord != record else {
            return
        }

        lastAdvancedRecord = record
        record = updatedRecord
        repository.saveRecord(record)
    }

    func undoAdvanceHole() {
        guard let lastAdvancedRecord else {
            return
        }

        record = lastAdvancedRecord
        self.lastAdvancedRecord = nil
        repository.saveRecord(record)
    }

    func reset() {
        lastAdvancedRecord = nil
        record = .initial
        showsResetConfirmation = false
        repository.saveRecord(record)
    }

    private func update(_ metric: GolfCountMetric, delta: Int) {
        var updatedRecord = record
        metric.applying(delta: delta, to: &updatedRecord)

        guard updatedRecord != record else {
            return
        }

        lastAdvancedRecord = nil
        record = updatedRecord
        repository.saveRecord(record)
    }
}
