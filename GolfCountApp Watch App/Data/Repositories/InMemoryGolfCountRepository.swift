//
//  InMemoryGolfCountRepository.swift
//  GolfCountApp Watch App
//

import Foundation

#if DEBUG
struct InMemoryGolfCountRepository: GolfCountRepository {
    let record: GolfCountRecord

    func loadRecord() -> GolfCountRecord {
        record
    }

    func saveRecord(_ record: GolfCountRecord) {}
}
#endif
