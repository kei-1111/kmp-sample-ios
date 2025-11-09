//
//  KmpSampleIOSApp.swift
//  KmpSampleIOS
//
//  Created by 犬飼啓太郎 on 2025/11/08.
//

import Shared
import SwiftUI

@main
struct KmpSampleIOSApp: App {
    init() {
        KoinKt.doInitKoin(appContext: nil)
    }
    var body: some Scene {
        WindowGroup {
            ContentView(hoge: "Hoge")
        }
    }
}
