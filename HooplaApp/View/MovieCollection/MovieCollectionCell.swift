//
//  MovieCollectionCell.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import SwiftUI

struct MovieCollectionCell: View {
    @EnvironmentObject private var moviesVM: MoviesViewModel
    @Environment(\.colorScheme) private var colorScheme

    let movie: MovieSummary
    @State var image: UIImage?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Image Section
            Group {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 160, height: 220)
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80, height: 120)
                        .foregroundColor(.gray.opacity(0.7))
                }
            }
            .frame(width: 160, height: 220)
            .background(Color(UIColor.secondarySystemBackground))
            .cornerRadius(10)
            .shadow(color: shadowColor, radius: 4)

            // Content Type with dynamic icons
            if let contentType = movie.contentType {
                HStack {
                    contentTypeIcon(for: contentType)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 12)
                        .foregroundColor(Color("BrandBlue"))
                    Text(contentType.rawValue.capitalized)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            // Title and Author
            Text(movie.title ?? "Untitled")
                .font(.headline)
                .lineLimit(1)
                .truncationMode(.tail)
                .foregroundColor(.primary)

            Text(movie.author ?? "Unknown Author")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .task {
            self.image = await moviesVM.getImage(movie.imageURL)
        }
    }

    // MARK: - Helper
    
    private var shadowColor: Color {
        colorScheme == .dark ? Color.white.opacity(0.5) : Color.black.opacity(0.5)
    }

    private func contentTypeIcon(for contentType: MovieSummary.ContentType) -> Image {
        switch contentType {
        case .movie:
            return Image(systemName: "film.fill")
        case .audiobook:
            return Image(systemName: "headphones")
        case .comic:
            return Image(systemName: "book.closed.fill")
        case .tv:
            return Image(systemName: "tv.fill")
        case .music:
            return Image(systemName: "music.note")
        }
    }
}

struct MovieCollectionCell_Previews: PreviewProvider {
    static var previews: some View {
        let mockMovie = MovieSummary(
            id: 1,
            title: "The Grand Adventure",
            author: "John Doe",
            contentType: .movie,
            imageURL: URL(string: "https://picsum.photos/300/450")!
        )

        Group {
            MovieCollectionCell(movie: mockMovie)
                .environmentObject(PreviewMockMoviesViewModel())
                .previewLayout(.sizeThatFits)
                .padding()
                .preferredColorScheme(.light)

            MovieCollectionCell(movie: mockMovie)
                .environmentObject(PreviewMockMoviesViewModel())
                .previewLayout(.sizeThatFits)
                .padding()
                .preferredColorScheme(.dark)
        }
    }
}
