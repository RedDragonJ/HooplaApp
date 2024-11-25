//
//  EmptyView.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import SwiftUI

struct EmptyStateView: View {

    let message: String
    let onRefresh: () -> Void

    var body: some View {
        VStack {
            VStack(spacing: 16) {
                Image(systemName: "tray")
                    .font(.system(size: 50))
                    .foregroundColor(.gray)
                Text(message)
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(.bottom, 16)
                Button(action: onRefresh) {
                    Text("Refresh")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 50)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmptyStateView(message: "No Recipes") {
                // Do nothing
            }
            .previewDisplayName("Light Mode")
            .preferredColorScheme(.light)

            EmptyStateView(message: "No Recipes") {
                // Do nothing
            }
            .previewDisplayName("Dark Mode")
            .preferredColorScheme(.dark)
        }
    }
}
