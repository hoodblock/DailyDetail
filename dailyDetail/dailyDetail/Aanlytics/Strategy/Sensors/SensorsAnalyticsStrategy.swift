//
//  SensorsAnalyticsStrategy.swift
//  dailyDetail
//
//  Created by nan on 2025/9/7.
//

import Foundation
import SensorsAnalyticsSDK

// MARK: - SensorsAnalytics 实现

class SensorsAnalyticsStrategy: AnalyticsProtocol {
    
    var type: AnalyticsType = .sensors
    
    func initialize(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let config = SAConfigOptions(serverURL: "https://your.sensors.server", launchOptions: launchOptions)
        config.autoTrackEventType = [.eventTypeAppStart, .eventTypeAppEnd, .eventTypeAppViewScreen]
        config.enableLog = true
        SensorsAnalyticsSDK.start(configOptions: config)
    }

    func track(event: String, parameters: [String: Any]) {
        SensorsAnalyticsSDK.sharedInstance()?.track(event, withProperties: parameters)
    }
    
    func handleOpen(url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) {
        SensorsAnalyticsSDK.sharedInstance()?.handleSchemeUrl(url)
    }
    
    func startViewTrack(event: String) {
        SensorsAnalyticsSDK.sharedInstance()?.trackTimerStart(event)
    }
      
    func endViewTrack(event: String, parameters: [String: Any]) {
        SensorsAnalyticsSDK.sharedInstance()?.trackTimerEnd(event, withProperties: parameters)
    }
}
