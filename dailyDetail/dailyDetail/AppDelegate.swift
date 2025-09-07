//
//  AppDelegate.swift
//  dailyDetail
//
//  Created by nan on 2025/9/7.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        // 注册
        AnalyticsManager.shared.register(strategy: SensorsAnalyticsStrategy(), enabled: false)
        AnalyticsManager.shared.register(strategy: AppsFlyerAnalyticsStrategy(), enabled: false)
        AnalyticsManager.shared.register(strategy: ZhugeAnalyticsStrategy(), enabled: true)
        // 公共属性
//        AnalyticsManager.shared.setSuperProperties([
//            CommonProperty.channel: "AppStore",
//            CommonProperty.version: Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
//        ])
        // 初始化
        AnalyticsManager.shared.initializeAll(launchOptions: launchOptions)
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AnalyticsManager.shared.handleOpen(url: url, options: options)
        return true
    }

}

