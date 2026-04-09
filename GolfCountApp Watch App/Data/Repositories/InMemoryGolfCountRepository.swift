//
//  InMemoryGolfCountRepository.swift
//  GolfCountApp Watch App
//

import Foundation

#if DEBUG
struct InMemoryGolfCountRepository: GolfCountRepository {
    let session: GolfCountSession

    init(session: GolfCountSession = .preview) {
        self.session = session
    }

    init(record: GolfCountRecord) {
        session = GolfCountSession(
            currentRecord: record,
            isRoundActive: true,
            currentRoundStartedAt: nil,
            completedRounds: []
        )
    }

    func loadSession() -> GolfCountSession {
        session
    }

    func saveSession(_ session: GolfCountSession) {}
}
#endif
