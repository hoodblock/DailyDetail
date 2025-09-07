//
//  AppsFlyerAnalyticsStrategy.swift
//  dailyDetail
//
//  Created by nan on 2025/9/7.
//

import Foundation
import AppsFlyerLib
import UIKit

// MARK: - AppsFlyer 实现
class AppsFlyerAnalyticsStrategy: NSObject, AnalyticsProtocol {
    
    var type: AnalyticsType = .appsFlyer
    
    func initialize(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let appsFlyer = AppsFlyerLib.shared()
        appsFlyer.appsFlyerDevKey = "your_dev_key"
        appsFlyer.appleAppID = "your_app_id"
        appsFlyer.isDebug = true
        appsFlyer.start()
    }

    func track(event: String, parameters: [String: Any]) {
        AppsFlyerLib.shared().logEvent(event, withValues: parameters)
    }

    func handleOpen(url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) {
        AppsFlyerLib.shared().handleOpen(url, options: options)
    }

}
