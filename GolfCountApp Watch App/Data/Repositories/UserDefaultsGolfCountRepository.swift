//
//  UserDefaultsGolfCountRepository.swift
//  GolfCountApp Watch App
//

import Foundation

struct UserDefaultsGolfCountRepository: GolfCountRepository {
    private enum Keys {
        static let roundRecord = "roundRecord"
        static let legacyHoleNumber = "holeNumber"
        static let legacyStrokes = "strokes"
        static let legacyPenalty = "penalty"
        static let legacyPutts = "putts"
    }

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func loadRecord() -> GolfCountRecord {
        if let data = userDefaults.data(forKey: Keys.roundRecord),
           let record = try? JSONDecoder().decode(GolfCountRecord.self, from: data) {
            return record
        }

        return migrateLegacyRecord()
    }

    func saveRecord(_ record: GolfCountRecord) {
        guard let data = try? JSONEncoder().encode(record) else {
            return
        }

        userDefaults.set(data, forKey: Keys.roundRecord)
    }

    private func migrateLegacyRecord() -> GolfCountRecord {
        let selectedHoleNumber: Int

        if userDefaults.object(forKey: Keys.legacyHoleNumber) == nil {
            selectedHoleNumber = GolfCountRecord.initial.selectedHoleNumber
        } else {
            selectedHoleNumber = min(max(1, userDefaults.integer(forKey: Keys.legacyHoleNumber)), GolfCountRecord.holeCount)
        }

        var record = GolfCountRecord.initial
        record.selectHole(selectedHoleNumber)
        record.apply(delta: userDefaults.integer(forKey: Keys.legacyStrokes), for: .strokes)
        record.apply(delta: userDefaults.integer(forKey: Keys.legacyPutts), for: .putts)
        record.apply(delta: userDefaults.integer(forKey: Keys.legacyPenalty), for: .penalty)
        return record
    }
}
