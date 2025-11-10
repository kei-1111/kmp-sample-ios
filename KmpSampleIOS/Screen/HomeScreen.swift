//
//  HomeScreen.swift
//  KmpSampleIOS
//
//  Created by 犬飼啓太郎 on 2025/11/08.
//

import Shared
import SwiftUI

struct HomeScreen: View {
    @StateObject private var observer = HomeViewModelObserver()

    var body: some View {
        VStack(spacing: 20) {
            switch observer.state {
            case is HomeUiStateInit:
                Text("Welcome to Home Screen")
                    .font(.title2)

            case is HomeUiStateLoading:
                Text("Loading...")
                    .font(.title2)

            case let stable as HomeUiStateStable:
                VStack(spacing: 12) {
                    Text("Stable State")
                        .font(.title2)
                        .bold()
                    Text("Mars Properties Count: \(stable.marsPropertyUiModels.count)")
                        .font(.body)

                    if let selected = stable.selectedPropertyUiModel {
                        Text("Selected Property: \(selected.id)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

            case let error as HomeUiStateError:
                VStack(spacing: 8) {
                    Text("Error")
                        .font(.title2)
                        .foregroundColor(.red)
                    Text(error.message)
                        .font(.body)
                        .foregroundColor(.secondary)
                }

            default:
                Text("Unknown State")
                    .foregroundColor(.gray)
            }
        }
        .task { await observer.startObserving() }
    }
}
