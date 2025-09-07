//
//  AnalyticsTimer.swift
//  dailyDetail
//
//  Created by nan on 2025/9/7.
//

import Foundation

class AnalyticsTimer {
    
    static let shared = AnalyticsTimer()
    private var timers: [String: Date] = [:]
    
    private init() {}
    
    func start(event: String) {
        timers[event] = Date()
    }
    
    func end(event: String) -> TimeInterval {
        guard let start = timers[event] else { return 0 }
        let duration = Date().timeIntervalSince(start)
        timers.removeValue(forKey: event)
        return duration
    }
}
