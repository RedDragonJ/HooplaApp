//
//  ErrorView.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import SwiftUI

struct ErrorView: View {

    let errorMessage: String
    let retryAction: () -> Void

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "exclamationmark.triangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.red)

            Text("Oops! Something went wrong.")
                .font(.headline)

            Text(errorMessage)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Button(action: retryAction) {
                Text("Try Again")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 40)
        }
        .padding(.vertical, 40)
        .background(Color(UIColor.systemBackground))
        .cornerRadius(12)
        .shadow(color: colorScheme == .dark ? Color.white : Color.black, radius: 5)
        .padding()
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorView(errorMessage: "An unexpected error occurred") {
                // Do nothing
            }
            .previewDisplayName("Light Mode")
            .preferredColorScheme(.light)

            ErrorView(errorMessage: "An unexpected error occurred") {
                // Do nothing
            }
            .previewDisplayName("Dark Mode")
            .preferredColorScheme(.dark)
        }
    }
}
