//
//  WatchDesign.swift
//  GolfCountApp Watch App
//

import SwiftUI

enum WatchDesign {
    static let screenPadding: CGFloat = 10
    static let sectionSpacing: CGFloat = 12
    static let cardPadding: CGFloat = 14
    static let cardCornerRadius: CGFloat = 18
    static let valuePanelHeight: CGFloat = 52
    static let buttonHeight: CGFloat = 56

    static let screenBackground = LinearGradient(
        colors: [
            Color(red: 0.05, green: 0.12, blue: 0.10),
            Color(red: 0.02, green: 0.05, blue: 0.05)
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    static let summaryBackground = LinearGradient(
        colors: [
            Color(red: 0.16, green: 0.44, blue: 0.28),
            Color(red: 0.10, green: 0.28, blue: 0.18)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let cardBackground = Color.white.opacity(0.10)
    static let valueBackground = Color.black.opacity(0.18)
    static let enteredHoleColor = Color(red: 0.70, green: 0.97, blue: 0.77)
}
