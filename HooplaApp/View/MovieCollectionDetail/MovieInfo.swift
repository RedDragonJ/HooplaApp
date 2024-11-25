//
//  MovieInfo.swift
//  HooplaApp
//
//  Created by James Layton on 11/24/24.
//

import SwiftUI

struct MovieInfoView: View {
    @Environment(\.colorScheme) private var colorScheme

    let titleDetails: TitleDetail

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Title
            if let title = titleDetails.title {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }

            // Author and Content Type
            HStack(spacing: 8) {
                if let author = titleDetails.author {
                    Text(author)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                if let contentType = titleDetails.contentType {
                    Text(contentTypeText(for: contentType))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }

            // Synopsis
            if let synopsis = titleDetails.synopsis {
                VStack(alignment: .leading, spacing: 4) {
                    Text(synopsis)
                        .multilineTextAlignment(.leading)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.secondarySystemBackground))
                .shadow(color: shadowColor, radius: 4)
        )
    }

    // MARK: - Helper
    
    private func contentTypeText(for contentType: TitleDetail.ContentType?) -> String {
        guard let contentType = contentType else {
            return "N/A"
        }
        return "• \(contentType.rawValue.capitalized)"
    }

    private var shadowColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5)
    }
}

struct MovieInfoView_Previews: PreviewProvider {
    static var previews: some View {
        return Group {
            MovieInfoView(titleDetails: mockMovieDetails)
                .previewDisplayName("Light Mode")
                .preferredColorScheme(.light)
                .padding()

            MovieInfoView(titleDetails: mockMovieDetails)
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
                .padding()
        }
    }
}
