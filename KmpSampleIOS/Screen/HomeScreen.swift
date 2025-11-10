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
        NavigationView {
            VStack(spacing: 0) {
                switch observer.state {
                case is HomeUiStateInit:
                    Spacer()
                    Text("Welcome to Home Screen")
                        .font(.title2)
                    Spacer()

                case is HomeUiStateLoading:
                    Spacer()
                    ProgressView("Loading...")
                        .font(.title2)
                    Spacer()

                case let stable as HomeUiStateStable:
                    ScrollView {
                        LazyVGrid(
                            columns: [
                                GridItem(.adaptive(minimum: 150), spacing: 16)
                            ],
                            spacing: 16
                        ) {
                            ForEach(stable.marsPropertyUiModels, id: \.id) { property in
                                MarsPropertyCardView(
                                    marsProperty: property,
                                    onClick: {
                                        observer.onAction(
                                            HomeUiActionOnClickMarsPropertyCard(marsProperty: property)
                                        )
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .padding(.bottom, 16)
                    }
                    .sheet(isPresented: Binding(
                        get: { stable.selectedPropertyUiModel != nil },
                        set: { if !$0 {
                            observer.onAction(HomeUiActionOnDismissMarsPropertyDetailDialog())
                        }}
                    )) {
                        if let property = stable.selectedPropertyUiModel {
                            MarsPropertyDetailBottomSheet(
                                marsProperty: property,
                                onDismiss: {
                                    observer.onAction(HomeUiActionOnDismissMarsPropertyDetailDialog())
                                }
                            )
                        }
                    }

                case let error as HomeUiStateError:
                    Spacer()
                    VStack(spacing: 8) {
                        Text("Error")
                            .font(.title2)
                            .foregroundColor(.red)
                        Text(error.message)
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    Spacer()

                default:
                    Spacer()
                    Text("Unknown State")
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            .navigationTitle("Mars Photos")
            .navigationBarTitleDisplayMode(.large)
        }
        .task { await observer.startObserving() }
    }
}
