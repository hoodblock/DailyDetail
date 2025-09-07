//
//  AppsFlyerEvents.swift
//  dailyDetail
//
//  Created by nan on 2025/9/7.
//

import Foundation

// MARK: - AppsFlyer 专属

enum AppsFlyerEvent {
    static let purchase = "af_purchase"
    static let tutorialComplete = "af_tutorial_completion"
}

enum AppsFlyerProperty {
    static let revenue = "af_revenue"
    static let currency = "af_currency"
}
