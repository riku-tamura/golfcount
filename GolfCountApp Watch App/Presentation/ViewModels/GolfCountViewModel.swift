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

    init(repository: any GolfCountRepository) {
        self.repository = repository
        record = repository.loadRecord()
    }

    var summary: SummaryViewData {
        SummaryViewData(record: record)
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

    func selectHole(_ holeNumber: Int) {
        guard holeNumber != record.selectedHoleNumber else {
            return
        }

        var updatedRecord = record
        updatedRecord.selectHole(holeNumber)
        record = updatedRecord
        repository.saveRecord(record)
    }

    func reset() {
        record = .initial
        showsResetConfirmation = false
        repository.saveRecord(record)
    }

    private func update(_ metric: GolfCountMetric, delta: Int) {
        var updatedRecord = record
        updatedRecord.apply(delta: delta, for: metric)

        guard updatedRecord != record else {
            return
        }

        record = updatedRecord
        repository.saveRecord(record)
    }
}
