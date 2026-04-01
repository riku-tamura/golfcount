//
//  UserDefaultsGolfCountRepository.swift
//  GolfCountApp Watch App
//

import Foundation

struct UserDefaultsGolfCountRepository: GolfCountRepository {
    private enum Keys {
        static let holeNumber = "holeNumber"
        static let strokes = "strokes"
        static let penalty = "penalty"
        static let putts = "putts"
    }

    private let userDefaults: UserDefaults

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func loadRecord() -> GolfCountRecord {
        let holeNumber: Int

        if userDefaults.object(forKey: Keys.holeNumber) == nil {
            holeNumber = GolfCountRecord.initial.holeNumber
        } else {
            holeNumber = userDefaults.integer(forKey: Keys.holeNumber)
        }

        return GolfCountRecord(
            holeNumber: holeNumber,
            strokes: userDefaults.integer(forKey: Keys.strokes),
            penalty: userDefaults.integer(forKey: Keys.penalty),
            putts: userDefaults.integer(forKey: Keys.putts)
        )
    }

    func saveRecord(_ record: GolfCountRecord) {
        userDefaults.set(record.holeNumber, forKey: Keys.holeNumber)
        userDefaults.set(record.strokes, forKey: Keys.strokes)
        userDefaults.set(record.penalty, forKey: Keys.penalty)
        userDefaults.set(record.putts, forKey: Keys.putts)
    }
}
