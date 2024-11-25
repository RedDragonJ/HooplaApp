//
//  MovieThumbnail.swift
//  HooplaApp
//
//  Created by James Layton on 11/24/24.
//

import SwiftUI
import UIKit

struct MovieThumbnailView: View {
    @Environment(\.colorScheme) private var colorScheme

    let thumbnail: UIImage?
    let imageURL: URL?
    @Binding var showPlayAlert: Bool

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // Gradient Background
            LinearGradient(
                gradient: Gradient(colors: gradientColors),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(maxWidth: .infinity, maxHeight: 320)
            .cornerRadius(12)
            .shadow(color: shadowColor, radius: 4)

            // Thumbnail Image
            if let thumbnail {
                Image(uiImage: thumbnail)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: 280)
                    .cornerRadius(10)
            } else {
                FallbackImageView()
            }

            // Play Button
            PlayButtonOverlay()
                .padding(16)
                .onTapGesture {
                    showPlayAlert = true
                }
        }
    }

    // MARK: - Helper
    
    private var gradientColors: [Color] {
        if colorScheme == .dark {
            return [Color.white.opacity(0.15), Color.clear]
        } else {
            return [Color.black.opacity(0.3), Color.clear]
        }
    }

    private var shadowColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5)
    }
}

struct PlayButtonOverlay: View {
    var body: some View {
        Image(systemName: "play.circle.fill")
            .font(.system(size: 60))
            .foregroundColor(.white)
            .shadow(radius: 10)
    }
}

struct FallbackImageView: View {
    var body: some View {
        VStack {
            Image(systemName: "photo.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .cornerRadius(12)
                .foregroundColor(.gray.opacity(0.7))
                .shadow(radius: 4)
        }
        .frame(maxWidth: .infinity, maxHeight: 300)
        .background(Color.clear)
    }
}

struct MovieThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleImage = UIImage(systemName: "film.fill")
        let sampleURL = URL(string: "https://picsum.photos/300/450")

        Group {
            MovieThumbnailView(
                thumbnail: sampleImage,
                imageURL: sampleURL,
                showPlayAlert: .constant(false)
            )
            .previewDisplayName("Light Mode")
            .preferredColorScheme(.light)

            MovieThumbnailView(
                thumbnail: sampleImage,
                imageURL: sampleURL,
                showPlayAlert: .constant(false)
            )
            .previewDisplayName("Dark Mode")
            .preferredColorScheme(.dark)
        }
    }
}
