//
//  GolfCountRepository.swift
//  GolfCountApp Watch App
//

import Foundation

protocol GolfCountRepository {
    func loadSession() -> GolfCountSession
    func saveSession(_ session: GolfCountSession)
}
