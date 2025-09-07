//
//  ViewController.swift
//  dailyDetail
//
//  Created by nan on 2025/9/7.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 上报
   
        
        AnalyticsManager.shared.track(
            event: "home_page", parameters: nil
        )
    }


}

