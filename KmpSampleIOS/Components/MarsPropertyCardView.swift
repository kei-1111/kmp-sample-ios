//
//  MarsPropertyCardView.swift
//  KmpSampleIOS
//
//  Component for displaying Mars property information
//

import Shared
import SwiftUI

struct MarsPropertyCardView: View {
    let marsProperty: MarsPropertyUiModel
    let onClick: () -> Void

    var body: some View {
        Button(action: onClick) {
            VStack(alignment: .leading, spacing: 0) {
                // Image with property type badge
                ZStack(alignment: .topTrailing) {
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
                                .aspectRatio(1, contentMode: .fill)
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
                    .clipped()

                    // Property type badge
                    Text(propertyTypeText())
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(Color.red.opacity(0.9))
                        .foregroundColor(.white)
                        .clipShape(
                            RoundedCorner(
                                radius: 12,
                                corners: [.bottomLeft]
                            )
                        )
                }

                // Price
                VStack(alignment: .leading, spacing: 4) {
                    Text(marsProperty.price)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color(.systemBackground))
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private func propertyTypeText() -> String {
        switch marsProperty.type {
        case .buy:
            return "BUY"
        case .rent:
            return "RENT"
        }
    }
}

// Custom shape for rounded corners on specific corners
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
