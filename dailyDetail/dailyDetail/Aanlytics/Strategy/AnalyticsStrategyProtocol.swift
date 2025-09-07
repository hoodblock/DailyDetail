//
//  AnalyticsStrategyProtocol.swift
//  dailyDetail
//
//  Created by nan on 2025/9/7.
//

import Foundation
import UIKit


enum AnalyticsType: String {
    /// 神策
    case sensors = "sensors"
    /// AppsFlyer
    case appsFlyer = "appsFlyer"
    /// 诸葛IO
    case zhugeio = "zhugeio"

}

protocol AnalyticsProtocol {
    /// 类型
    var type: AnalyticsType { get }
    
    /// 初始化
    func initialize(launchOptions: [UIApplication.LaunchOptionsKey: Any]?)
    
    /// 上报事件
    func track(event: String, parameters: [String: Any])
    
    /// 默认空实现，部分 SDK 需要（AppsFlyer / 神策 / 诸葛）
    func handleOpen(url: URL, options: [UIApplication.OpenURLOptionsKey: Any])
    
    /// 上报页面浏览时长
    /// 开始计时
    func startViewTrack(event: String)
    /// 结束计时
    func endViewTrack(event: String, parameters: [String: Any])
}

/// URL 回调
extension AnalyticsProtocol {
    
    func handleOpen(url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) { }
    
}

/// 时长统计
extension AnalyticsProtocol {
    
    func startViewTrack(event: String) { }
    
    func endViewTrack(event: String, parameters: [String: Any] = [:]) { }
    
}
