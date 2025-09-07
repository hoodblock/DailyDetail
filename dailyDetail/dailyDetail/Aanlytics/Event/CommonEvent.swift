//
//  CommonEvent.swift
//  dailyDetail
//
//  Created by nan on 2025/9/7.
//

import Foundation


// MARK: - 公共事件名 & 属性表

enum CommonEvent {
    static let appLaunch = "app_launch"
    static let appTerminate = "app_terminate"
    static let purchase = "purchase"
    static let videoPlay = "video_play"
}

enum CommonProperty {
    static let userId = "user_id"
    static let channel = "channel"
    static let version = "version"
    static let itemId = "item_id"
    static let duration = "duration"
}
