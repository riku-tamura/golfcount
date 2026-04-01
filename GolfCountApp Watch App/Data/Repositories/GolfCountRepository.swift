//
//  GolfCountRepository.swift
//  GolfCountApp Watch App
//

import Foundation

protocol GolfCountRepository {
    func loadRecord() -> GolfCountRecord
    func saveRecord(_ record: GolfCountRecord)
}
