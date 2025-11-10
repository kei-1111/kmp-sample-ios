//
//  KmpSampleIOSApp.swift
//  KmpSampleIOS
//
//  Created by 犬飼啓太郎 on 2025/11/08.
//

import SwiftUI

@main
struct KmpSampleIOSApp: App {
    init() {
        initKoin()
    }
    var body: some Scene {
        WindowGroup {
          HomeScreen()
        }
    }
}
