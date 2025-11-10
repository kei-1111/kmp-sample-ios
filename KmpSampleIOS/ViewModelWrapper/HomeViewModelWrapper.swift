//
//  HomeViewModelWrapper.swift
//  KmpSampleIOS
//
//  ViewModel wrapper for SwiftUI integration
//

import Shared
import SwiftUI

@MainActor
class HomeViewModelWrapper: ObservableObject {
    var viewModel: HomeViewModel = ViewModelProvider.shared.provideHomeViewModel()
    @Published var state: HomeUiState = HomeUiStateInit()

    func startObserving() async {
        for await newState in viewModel.state {
            self.state = newState
        }
    }

    func onAction(_ action: HomeUiAction) {
        viewModel.onAction(action: action)
    }
}
