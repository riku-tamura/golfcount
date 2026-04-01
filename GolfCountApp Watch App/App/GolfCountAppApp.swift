//
//  GolfCountAppApp.swift
//  GolfCountApp Watch App
//
//  Created by riku on 2026/04/01.
//

import SwiftUI

@main
struct GolfCountApp_Watch_AppApp: App {
    private let dependencyContainer = AppDependencyContainer()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: dependencyContainer.makeGolfCountViewModel())
        }
    }
}
