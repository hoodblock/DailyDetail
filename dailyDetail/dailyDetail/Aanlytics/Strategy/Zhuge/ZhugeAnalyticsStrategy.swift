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
    
    let app_id: String = "504153"
    let app_key: String = "edcf694804a9428386e4391f3615fb09"
    let secret_key: String = "9c6a2c3012f344f7896498e70d07662f"
    
    func initialize(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        let zhuge = Zhuge.sharedInstance()
        //默认关闭实时调试 true打开
        zhuge.config.debug = false
        zhuge.config.autoTrackEnable = true
        zhuge.config.enableCodeless = true
        zhuge.config.enableLoger = true
        zhuge.config.sessionInterval = 0
        zhuge.config.sendInterval = 0
        
        // 开启行为追踪
        zhuge.start(withAppKey: app_key, launchOptions: launchOptions)
        // 识别用户
        zhuge.identify("2222222222", properties: ["name" : "meng",
                                                                      "age" : "50"
                                                                     ])
    }

    func track(event: String, parameters: [String: Any]) {
        Zhuge.sharedInstance().track(event, properties: parameters)
    }
    
    func startViewTrack(event: String) {
        Zhuge.sharedInstance().startTrack(event)
    }
      
    func endViewTrack(event: String, parameters: [String: Any]) {
        Zhuge.sharedInstance().endTrack(event, properties: parameters)
    }
}
