//
//  AppDependencyContainer.swift
//  GolfCountApp Watch App
//

import Foundation

struct AppDependencyContainer {
    private let repository: any GolfCountRepository

    init(userDefaults: UserDefaults = .standard) {
        repository = UserDefaultsGolfCountRepository(userDefaults: userDefaults)
    }

    @MainActor
    func makeGolfCountViewModel() -> GolfCountViewModel {
        GolfCountViewModel(repository: repository)
    }
}
