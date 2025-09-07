//
//  AnalyticsManager.swift
//  dailyDetail
//
//  Created by nan on 2025/9/7.
//

import Foundation
import UIKit

// MARK: - Analytics 管理器

class AnalyticsManager {
    
    static let shared = AnalyticsManager()
    
    private var strategies: [AnalyticsType: AnalyticsProtocol] = [:]
    private var enabledSDKs: Set<AnalyticsType> = []
    private var superProperties: [String: Any] = [:]

    private init() {}

    /// 注册 SDK 策略
    func register(strategy: AnalyticsProtocol, enabled: Bool = true) {
        strategies[strategy.type] = strategy
        if enabled {
            enabledSDKs.insert(strategy.type)
        }
    }

    /// 初始化所有启用的 SDK
    func initializeAll(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        for sdkType in enabledSDKs {
            strategies[sdkType]?.initialize(launchOptions: launchOptions)
            log("[Init] \(sdkType) 初始化完成")
        }
    }

    func handleOpen(url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) {
        for sdkType in enabledSDKs {
            strategies[sdkType]?.handleOpen(url: url, options: options)
            log("[OpenURL] \(sdkType) 处理了 URL: \(url)")
        }
    }
    
    /// 设置全局属性
    func setSuperProperties(_ properties: [String: Any]) {
        superProperties.merge(properties) { _, new in new }
    }

    /// 上报事件（可选指定 SDK）
    func track(event: String, parameters: [String: Any], to sdks: [AnalyticsType]? = nil) {
        let targetSDKs = sdks ?? Array(enabledSDKs)
        let merged = superProperties.merging(parameters) { _, new in new }

        for sdk in targetSDKs {
            if enabledSDKs.contains(sdk), let strategy = strategies[sdk] {
                let mappedEvent = mapEvent(event, for: sdk)
                strategy.track(event: mappedEvent, parameters: merged)
                log("[Track] \(sdk) 上报事件: \(mappedEvent) 参数: \(merged)")
            }
        }
    }

    /// 动态开关 SDK
    func enableSDK(_ type: AnalyticsType, enable: Bool) {
        if enable {
            enabledSDKs.insert(type)
        } else {
            enabledSDKs.remove(type)
        }
    }

    /// 事件映射表（公共 -> 各 SDK）
    private let eventMapping: [String: [AnalyticsType: String]] = [
        CommonEvent.purchase: [
            .appsFlyer: AppsFlyerEvent.purchase,
            .sensors: CommonEvent.purchase,
            .zhugeio: CommonEvent.purchase
        ],
        CommonEvent.videoPlay: [
            .sensors: CommonEvent.videoPlay,
            .zhugeio: CommonEvent.videoPlay
        ]
    ]

    private func mapEvent(_ event: String, for sdk: AnalyticsType) -> String {
        return eventMapping[event]?[sdk] ?? event
    }

    private func log(_ message: String) {
#if DEBUG
        print("📊 Analytics: \(message)")
#endif
    }
}

