//
//  MovieDetail.swift
//  HooplaApp
//
//  Created by James Layton on 11/23/24.
//

import SwiftUI

struct MovieCollectionDetail: View {
    @EnvironmentObject private var moviesVM: MoviesViewModel
    @State private var thumbNail: UIImage?
    @State private var showPlayAlert = false

    let movieID: Int

    var body: some View {
        ZStack {
            switch moviesVM.movieDetailsViewState {
            case .loading:
                LoadingView()
            case .success:
                if let titleDetails = moviesVM.titleDetails {
                    ScrollView {
                        VStack(spacing: 16) {
                            // Thumbnail Section
                            MovieThumbnailView(
                                thumbnail: thumbNail,
                                imageURL: titleDetails.imageURL,
                                showPlayAlert: $showPlayAlert
                            )

                            // Info Section
                            MovieInfoView(titleDetails: titleDetails)
                                .padding(.horizontal)
                        }
                        .padding(.top)
                    }
                    .navigationBarTitle(contentTitle(for: titleDetails.contentType), displayMode: .inline)
                    .alert(isPresented: $showPlayAlert) {
                        Alert(
                            title: Text("Start Watching"),
                            message: Text(alertMessage(for: titleDetails.contentType, title: titleDetails.title)),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                } else {
                    EmptyStateView(message: "No Movie Details") {
                        getMovieDetails()
                    }
                }
            case .error(let errorMessage):
                ErrorView(errorMessage: errorMessage) {
                    getMovieDetails()
                }
            }
        }
        .onAppear(perform: getMovieDetails)
    }

    // MARK: - Helper
    
    private func getMovieDetails() {
        Task {
            await moviesVM.fetchMovieDetails(K.URL.baseURL, titleID: movieID)
            if let titleDetails = moviesVM.titleDetails {
                self.thumbNail = await moviesVM.getImage(titleDetails.imageURL)
            }
        }
    }

    private func contentTitle(for contentType: TitleDetail.ContentType?) -> String {
        let type = contentType?.rawValue.capitalized ?? "Content"
        return "\(type) Detail"
    }

    private func alertMessage(for contentType: TitleDetail.ContentType?, title: String?) -> String {
        let safeTitle = title ?? "This content"
        guard let contentType = contentType else {
            return "\(safeTitle) is not available at the moment."
        }
        switch contentType {
        case .movie:
            return "Would you like to start watching the movie '\(safeTitle)'?"
        case .audiobook:
            return "Would you like to start listening to the audiobook '\(safeTitle)'?"
        case .comic:
            return "Would you like to start reading the comic '\(safeTitle)'?"
        case .tv:
            return "Would you like to start watching the TV show '\(safeTitle)'?"
        case .music:
            return "Would you like to start listening to the music '\(safeTitle)'?"
        }
    }
}

struct MovieCollectionDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MovieCollectionDetail(movieID: 1)
                .environmentObject(MoviesViewModel())
                .previewDisplayName("Light Mode")
                .preferredColorScheme(.light)

            MovieCollectionDetail(movieID: 1)
                .environmentObject(MoviesViewModel())
                .previewDisplayName("Dark Mode")
                .preferredColorScheme(.dark)
        }
    }
}
