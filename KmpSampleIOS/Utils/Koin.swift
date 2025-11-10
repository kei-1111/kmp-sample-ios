//
//  KoinHelper.swift
//  KmpSampleIOS
//
//  Helper class to get dependencies from Koin
//

import Foundation
import Shared

func initKoin() {
    KoinKt.doInitKoin(appContext: nil)
}
