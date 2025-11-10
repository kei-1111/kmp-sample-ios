//
//  MarsPropertyDetailBottomSheet.swift
//  KmpSampleIOS
//
//  Bottom sheet for displaying Mars property details
//

import Shared
import SwiftUI

struct MarsPropertyDetailBottomSheet: View {
    let marsProperty: MarsPropertyUiModel
    let onDismiss: () -> Void

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Property Image
                    AsyncImage(url: URL(string: marsProperty.imageUrl)) { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(
                                    ProgressView()
                                )
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        case .failure:
                            Rectangle()
                                .fill(Color.gray.opacity(0.3))
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(
                                    Image(systemName: "photo")
                                        .foregroundColor(.gray)
                                )
                        @unknown default:
                            EmptyView()
                        }
                    }

                    // Property Details
                    VStack(alignment: .leading, spacing: 16) {
                        // ID Section
                        VStack(alignment: .leading, spacing: 4) {
                            Text("ID")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(marsProperty.id)
                                .font(.body)
                        }

                        // Price Section
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Price")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(marsProperty.price)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.red)
                        }

                        // Sale Type Section
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Sale Type")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(propertyTypeText())
                                .font(.body)
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .navigationTitle("Property Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") {
                        onDismiss()
                    }
                }
            }
        }
    }

    private func propertyTypeText() -> String {
        switch marsProperty.type {
        case .buy:
            return "Buy"
        case .rent:
            return "Rent"
        }
    }
}
