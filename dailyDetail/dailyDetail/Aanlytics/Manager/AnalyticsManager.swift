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
    /// 策略器
    private var strategies: [AnalyticsType: AnalyticsProtocol] = [:]
    /// 配置策略开关
    private var enabledSDKs: Set<AnalyticsType> = []
    /// 每次事件上报的公共属性
    private var superProperties: [String: Any] = [:]

    private init() {}

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

}

// MARK: - Public 初始化和基础配置

extension AnalyticsManager {
    
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
    
    /// 设置全局属性
    func setSuperProperties(_ properties: [String: Any]) {
        superProperties.merge(properties) { _, new in new }
    }
    
    /// 处理URL
    func handleOpen(url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) {
        for sdkType in enabledSDKs {
            strategies[sdkType]?.handleOpen(url: url, options: options)
            log("[OpenURL] \(sdkType) 处理了 URL: \(url)")
        }
    }
    
}

// MARK: - Public 上报

extension AnalyticsManager {
    
    /// 上报事件（可选指定 SDK）
    public func track(event: String, parameters: [String: Any]?, to sdks: [AnalyticsType]? = nil) {
        let targetSDKs = sdks ?? Array(enabledSDKs)
        let merged = superProperties.merging(parameters ?? [:]) { _, new in new }

        for sdk in targetSDKs {
            if enabledSDKs.contains(sdk), let strategy = strategies[sdk] {
                let mappedEvent = mapEvent(event, for: sdk)
                strategy.track(event: mappedEvent, parameters: merged)
                log("[Track] \(sdk) 上报事件: \(mappedEvent) 参数: \(merged)")
            }
        }
    }
    
    /// 开始上报页面浏览时长（可选指定 SDK）
    public func startViewTrack(event: String, to sdks: [AnalyticsType]? = nil) {
        let targetSDKs = sdks ?? Array(enabledSDKs)
        for sdk in targetSDKs {
            if enabledSDKs.contains(sdk), let strategy = strategies[sdk] {
                let mappedEvent = mapEvent(event, for: sdk)
                strategy.startViewTrack(event: mappedEvent)
                log("[ViewTrack] \(sdk) 开始上报浏览时长: \(mappedEvent) ")
            }
        }
    }
    
    /// 结束上报页面浏览时长（可选指定 SDK）
    public func endViewTrack(event: String, parameters: [String: Any]?, to sdks: [AnalyticsType]? = nil) {
        let targetSDKs = sdks ?? Array(enabledSDKs)
        let merged = superProperties.merging(parameters ?? [:]) { _, new in new }

        for sdk in targetSDKs {
            if enabledSDKs.contains(sdk), let strategy = strategies[sdk] {
                let mappedEvent = mapEvent(event, for: sdk)
                strategy.endViewTrack(event: mappedEvent, parameters: merged)
                log("[ViewTrack] \(sdk) 结束上报浏览时长: \(mappedEvent) ")
            }
        }
    }
}


// MARK: - Private 方法

extension AnalyticsManager {
    
    /// 动态开关 SDK
    func enableSDK(_ type: AnalyticsType, enable: Bool) {
        if enable {
            enabledSDKs.insert(type)
        } else {
            enabledSDKs.remove(type)
        }
    }
    
    private func mapEvent(_ event: String, for sdk: AnalyticsType) -> String {
        return eventMapping[event]?[sdk] ?? event
    }

    private func log(_ message: String) {
        #if DEBUG
            print("📊 Analytics: \(message)")
        #endif
    }
}
