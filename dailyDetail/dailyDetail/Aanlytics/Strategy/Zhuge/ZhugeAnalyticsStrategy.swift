//
//  ZhugeAnalyticsStrategy.swift
//  dailyDetail
//
//  Created by nan on 2025/9/7.
//

import Foundation
import ZhugeioAnalytics
import UIKit

// MARK: - ZhugeIO 实现

class ZhugeAnalyticsStrategy: AnalyticsProtocol {
    
    var type: AnalyticsType = .zhugeio
    
    func initialize(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        Zhuge.sharedInstance().start(withAppKey: "your_zhuge_app_key", launchOptions: launchOptions)
    }

    func track(event: String, parameters: [String: Any]) {
        Zhuge.sharedInstance().track(event, properties: parameters)
    }
    
}
